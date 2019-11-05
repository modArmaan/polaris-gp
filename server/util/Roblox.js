/**
 * Manages bloxy and connectiongs to Roblox.
 */
const settings = require("../settings.json");
const Bloxy = require("bloxy");

const Roblox = new Bloxy({
	username: settings.user,
	password: settings.pass
});
const login = new Promise(async function (resolve) {
	Roblox.login();
	Roblox.once('ready', resolve);
});
let loggedIn = false;
const userRanks = {};
login.then(async function () {
	const userId = await Roblox.getIdByUsername(settings.user);
	let r = await Roblox.getUserGroups(userId);
	for (let g of r) {
		userRanks[g.group.groupId] = g.userRank;
	}
    loggedIn = true;
    console.log(`Logged in as ${settings.user}`);
}).catch(function (e) {
    console.log(`Failed to log in. ${e.message}`);
})
;
/**
 *
 * @param userId - The Roblox userId of the user to promote
 * @param groupId - The groupid to promote them in
 * @param newRank - The rank to promote them to
 * @return {boolean | object} - success or error
 */
async function setRank(userId, groupId, newRank) {
	if (!loggedIn) {
		console.log(`Can't rank user ${userId}. Not logged in yet.`);
		return false;
	}
	if (!userRanks[groupId]) {
		return {error: {message: "Bot is not in group."}};
	} else if (userRanks[groupId] <= newRank) {
		return {error: {message: `Cannot rank to ${newRank}. Bot rank is ${userRanks[groupId]}.`}};
	} else {
		// it's ok. Attempt to rank.
		try {
            const group = await Roblox.getGroup(groupId);
            const perms = await group.getMyPermissions();
            if (!perms.permissions.groupMembershipPermissions.changeRank) {
                return {error: {message: "No change rank permission"}};
            }
            const roleSet = await group.getRole({rank: newRank});
            const s = await group.setRank(userId, roleSet.id);
            if (s) {
				console.log(`Ranked user ${userId} to ${newRank} in ${groupId}.`);
			}
			return s;
		} catch (e) {
			console.error(e);
			return {error: {message: e}};
		}
	}

}
module.exports = {
	setRank: setRank
};