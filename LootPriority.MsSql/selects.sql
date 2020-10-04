USE LootPriority
GO

--INSERT INTO Player (Nickname) VALUES ('Zoey')
--INSERT INTO Player (Nickname) VALUES ('Bella')
--INSERT INTO Character (Name, PlayerID, ClassID, TeamID, RealmID) VALUES ( 'Zoey',  (SELECT ID FROM Player WHERE Nickname = 'Zoey'), (SELECT ID FROM Class WHERE Name = 'Mage'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), (SELECT ID FROM Realm WHERE Name = 'Grobbulus'))
--INSERT INTO Character (Name, PlayerID, ClassID, TeamID, RealmID) VALUES ( 'Parabella',  (SELECT ID FROM Player WHERE Nickname = 'Bella'), (SELECT ID FROM Class WHERE Name = 'Rogue'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), (SELECT ID FROM Realm WHERE Name = 'Grobbulus'))
--INSERT INTO Character (Name, PlayerID, ClassID, TeamID, RealmID) VALUES ( 'Bellafrost',  (SELECT ID FROM Player WHERE Nickname = 'Bella'), (SELECT ID FROM Class WHERE Name = 'Mage'), NULL, (SELECT ID FROM Realm WHERE Name = 'Grobbulus'))

--DELETE FROM Character
--DELETE FROM Player

--SELECT p.Nickname Player, c.Name Character, cl.Name Class, t.Name Team, r.Name Realm
--FROM Player p
--LEFT JOIN Character c
--ON c.PlayerID = p.ID
--LEFT JOIN Class cl
--ON cl.ID = c.ClassID
--LEFT JOIN Team t
--ON t.ID = c.TeamID
--LEFT JOIN Realm r
--ON r.ID = c.RealmID
--ORDER BY p.Nickname ASC, t.Name DESC, c.Name ASC



--INSERT INTO RaidLog (Name, RaidID, TeamID, StartDate, EndDate) VALUES ('Purple AQ 2020-09-23', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), '2020-09-23 18:00:00', '2020-09-23 20:00:00')
--INSERT INTO RaidLog (Name, RaidID, TeamID, StartDate, EndDate) VALUES ('Purple BWL 2020-09-27', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), '2020-09-27 18:00:00', '2020-09-27 19:00:00')
--INSERT INTO RaidLog (Name, RaidID, TeamID, StartDate, EndDate) VALUES ('Purple MC 2020-09-27', (SELECT ID FROM Raid WHERE Name = 'Molten Core'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), '2020-09-27 19:00:00', '2020-09-27 20:00:00')

--INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple AQ 2020-09-23'), (SELECT ID FROM Character WHERE Name = 'Zoey'))
--INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple BWL 2020-09-27'), (SELECT ID FROM Character WHERE Name = 'Zoey'))
--INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple MC 2020-09-27'), (SELECT ID FROM Character WHERE Name = 'Zoey'))
--INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple AQ 2020-09-23'), (SELECT ID FROM Character WHERE Name = 'Parabella'))
--INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple BWL 2020-09-27'), (SELECT ID FROM Character WHERE Name = 'Bellafrost'))
--INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple MC 2020-09-27'), (SELECT ID FROM Character WHERE Name = 'Parabella'))


--SELECT r.Name Raid, r.PlayerLimit, rr.ReleaseDate, re.Name Realm, b.Name Boss
--FROM Raid r
--LEFT JOIN RealmRaid rr
--ON rr.RaidID = r.ID
--LEFT JOIN Realm re
--ON re.ID = rr.RealmID
--LEFT JOIN Boss b
--ON b.RaidID = r.ID

--SELECT r.Name Raid, t.Name Team, rl.StartDate Start, rl.EndDate [End], c.Name Character, re.Name Realm, cl.Name Class
--FROM Raid r
--INNER JOIN RaidLog rl
--ON rl.RaidID = r.ID
--LEFT JOIN RaidLogCharacter rlc
--ON rlc.RaidLogID = rl.ID
--LEFT JOIN Character c
--ON c.ID = rlc.CharacterID
--LEFT JOIN Class cl
--ON cl.ID = c.ClassID
--LEFT JOIN Realm re
--ON re.ID = c.RealmID
--LEFT JOIN Team t
--ON t.ID = rl.TeamID



--DELETE FROM BossLoot;
--DELETE FROM ItemClass;
--DELETE FROM CharacterLoot;
--DELETE FROM Item;


--INSERT INTO ItemClassWeight (ItemID, ClassID, Weight) VALUES ((SELECT ID FROM Item WHERE Name = 'Ring of the Fallen God'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.0)
--INSERT INTO ItemClassWeight (ItemID, ClassID, Weight) VALUES ((SELECT ID FROM Item WHERE Name = 'Ring of the Fallen God'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.2)


SELECT * FROM (
SELECT 
	i.ID ItemID,
	i.Name Item, 
	i.Level ItemLevel, 
	s.Name Slot, 
	CASE 
		WHEN r.Name IS NULL THEN r2.Name
		ELSE r.Name
	END Raid, 
	CASE 
		WHEN b.ID IS NULL THEN b2.ID
		ELSE b.ID
	END BossID, 
	CASE 
		WHEN b.Name IS NULL THEN b2.Name
		ELSE b.Name
	END Boss, 
	CASE 
		WHEN bl.DropChance IS NULL THEN bl2.DropChance-- / (SELECT COUNT(*) FROM Item WHERE IsQuestItem = 0 AND RewardFromQuestItem = i2.ID)
		ELSE bl.DropChance
	END DropChance
FROM Item i
LEFT JOIN Slot s
ON i.SlotID = s.ID
LEFT JOIN Item i2
ON i.RewardFromQuestItem = i2.ID AND i2.IsQuestItem = 1
LEFT JOIN BossLoot bl
ON bl.ItemID = i.ID
LEFT JOIN Boss b
ON b.ID = bl.BossID
LEFT JOIN Raid r
ON b.RaidID = r.ID
LEFT JOIN BossLoot bl2
ON bl2.ItemID = i2.ID
LEFT JOIN Boss b2
ON b2.ID = bl2.BossID
LEFT JOIN Raid r2
ON b2.RaidID = r2.ID
WHERE i.IsQuestItem = 0) a
ORDER BY Raid ASC, BossID ASC, DropChance DESC

--SELECT 
--	i.ID,
--	i.Name, 
--	i.Level, 
--	s.Name Slot, 
--	i.IsQuestItem,
--	c.Name Class,
--	i2.ID QuestRewardID
--FROM Item i
--LEFT JOIN Slot s
--ON i.SlotID = s.ID
--LEFT JOIN ItemClass ic
--ON ic.ItemID = i.ID
--LEFT JOIN Class c
--ON c.ID = ic.ClassID
--LEFT JOIN Item i2
--ON i.ID = i2.RewardFromQuestItem
--ORDER BY i.IsQuestItem ASC


--SELECT COUNT(i.ID) ItemCount, c.Name
--FROM Item i
--LEFT JOIN ItemClass ic
--ON ic.ItemID = i.ID
--LEFT JOIN Class c
--ON c.ID = ic.ClassID
--GROUP BY c.Name

--SELECT t.ItemCount, s.Name, t.AverageLevel
--FROM (
--	SELECT COUNT(i.ID) ItemCount, i.SlotID, AVG(i.Level) AverageLevel
--	FROM Item i
--	LEFT JOIN ItemClass ic
--	ON ic.ItemID = i.ID
--	WHERE i.RewardFromQuestItem IS NULL AND i.IsQuestItem = 0
--	GROUP BY i.SlotID
--) t
--LEFT JOIN Slot s
--ON s.ID = t.SlotID
--ORDER BY t.AverageLevel DESC


--INSERT INTO CharacterLoot (CharacterID, ItemID, [Date]) VALUES ((SELECT ID FROM [Character] WHERE [Name] = 'Zoey'), (SELECT ID FROM Item WHERE [Name] = 'Boots of Epiphany'), '2020-08-24')
--INSERT INTO CharacterLoot (CharacterID, ItemID, [Date]) VALUES ((SELECT ID FROM [Character] WHERE [Name] = 'Zoey'), (SELECT ID FROM Item WHERE [Name] = 'Vek''nilash''s Circlet'), '2020-09-23')
--INSERT INTO CharacterLoot (CharacterID, ItemID, [Date]) VALUES ((SELECT ID FROM [Character] WHERE [Name] = 'Zoey'), (SELECT ID FROM Item WHERE [Name] = 'Eye of C''Thun'), '2020-09-30')
--INSERT INTO CharacterLoot (CharacterID, ItemID, [Date]) VALUES ((SELECT ID FROM [Character] WHERE [Name] = 'Zoey'), (SELECT ID FROM Item WHERE [Name] = 'Qiraji Bindings of Dominance'), '2020-09-30')


--SELECT
--	c.[Name] [Character], 
--	cla.[Name] Class, 
--	CASE 
--		WHEN i2.ID IS NULL THEN i.[Name]
--		ELSE i2.[Name]
--	END Item, 
--	cl.[Date]
--FROM CharacterLoot cl
--LEFT JOIN Item i
--ON cl.ItemID = i.ID
--LEFT JOIN Slot s
--ON i.SlotID = s.ID
--LEFT JOIN Item i2
--ON i2.RewardFromQuestItem = i.ID
--LEFT JOIN [Character] c
--ON c.ID = cl.CharacterID
--LEFT JOIN Class cla
--ON cla.ID = c.ClassID
--LEFT JOIN ItemClass ic
--ON ic.ItemID = i.ID AND ic.ClassID = cla.ID
--LEFT JOIN ItemClass ic2
--ON ic2.ItemID = i2.ID
--WHERE ((ic.ID IS NULL OR cla.ID = ic.ClassID) AND i.IsQuestItem = 0) OR ((ic2.ID IS NULL OR cla.ID = ic2.ClassID) AND i.IsQuestItem = 1)
--ORDER BY cla.[Name] ASC, c.[Name] ASC, cl.[Date] ASC



