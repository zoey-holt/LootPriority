USE master
GO

DROP DATABASE IF EXISTS LootPriority
GO

CREATE DATABASE LootPriority
GO

USE LootPriority
GO

--------------------------------
--           PLAYER           --
--------------------------------


CREATE TABLE Player (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Nickname VARCHAR(100) NULL,
)

CREATE TABLE Class (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NOT NULL,
)

CREATE TABLE Team (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NOT NULL,
)

CREATE TABLE Realm (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NOT NULL,
)

CREATE TABLE Character (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NOT NULL,
	PlayerID INT NOT NULL,
	ClassID INT NOT NULL,
	TeamID INT NULL,
	RealmID INT NOT NULL,
	FOREIGN KEY (PlayerID) REFERENCES Player (ID),
	FOREIGN KEY (ClassID) REFERENCES Class (ID),
	FOREIGN KEY (TeamID) REFERENCES Team (ID),
	FOREIGN KEY (RealmID) REFERENCES Realm (ID),
)


INSERT INTO Class (Name) VALUES ('Druid')
INSERT INTO Class (Name) VALUES ('Hunter')
INSERT INTO Class (Name) VALUES ('Mage')
INSERT INTO Class (Name) VALUES ('Paladin')
INSERT INTO Class (Name) VALUES ('Priest')
INSERT INTO Class (Name) VALUES ('Rogue')
INSERT INTO Class (Name) VALUES ('Shaman')
INSERT INTO Class (Name) VALUES ('Warlock')
INSERT INTO Class (Name) VALUES ('Warrior')

INSERT INTO Team (Name) VALUES ('ENCORE Purple')
INSERT INTO Team (Name) VALUES ('ENCORE Red')
INSERT INTO Team (Name) VALUES ('ENCORE Green')

INSERT INTO Realm (Name) VALUES ('Grobbulus')

INSERT INTO Player (Nickname) VALUES ('Zoey')
INSERT INTO Player (Nickname) VALUES ('Bella')
INSERT INTO Character (Name, PlayerID, ClassID, TeamID, RealmID) VALUES ( 'Zoey',  (SELECT ID FROM Player WHERE Nickname = 'Zoey'), (SELECT ID FROM Class WHERE Name = 'Mage'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), (SELECT ID FROM Realm WHERE Name = 'Grobbulus'))
INSERT INTO Character (Name, PlayerID, ClassID, TeamID, RealmID) VALUES ( 'Parabella',  (SELECT ID FROM Player WHERE Nickname = 'Bella'), (SELECT ID FROM Class WHERE Name = 'Rogue'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), (SELECT ID FROM Realm WHERE Name = 'Grobbulus'))
INSERT INTO Character (Name, PlayerID, ClassID, TeamID, RealmID) VALUES ( 'Bellafrost',  (SELECT ID FROM Player WHERE Nickname = 'Bella'), (SELECT ID FROM Class WHERE Name = 'Mage'), NULL, (SELECT ID FROM Realm WHERE Name = 'Grobbulus'))


--SELECT p.ID PlayerID, p.Nickname Player, c.Name Character, cl.Name Class, t.Name Team, r.Name Realm
--FROM Player p
--LEFT JOIN Character c
--ON c.PlayerID = p.ID
--LEFT JOIN Class cl
--ON cl.ID = c.ClassID
--LEFT JOIN Team t
--ON t.ID = c.TeamID
--LEFT JOIN Realm r
--ON r.ID = c.RealmID


--------------------------------
--            RAID            --
--------------------------------


CREATE TABLE Raid (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NOT NULL,
	PlayerLimit INT NOT NULL,
)

CREATE TABLE RealmRaid (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	ReleaseDate DATETIME NULL,
	RealmID INT NOT NULL,
	RaidID INT NOT NULL,
	FOREIGN KEY (RealmID) REFERENCES Realm (ID),
	FOREIGN KEY (RaidID) REFERENCES Raid (ID),
)

CREATE TABLE Boss (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NOT NULL,
	RaidID INT NOT NULL,
	FOREIGN KEY (RaidID) REFERENCES Raid (ID),
)

CREATE TABLE RaidLog (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NULL,
	RaidID INT NOT NULL,
	TeamID INT NULL,
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL,
	FOREIGN KEY (RaidID) REFERENCES Raid (ID),
	FOREIGN KEY (TeamID) REFERENCES Team (ID),
)

CREATE TABLE RaidLogCharacter (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	RaidLogID INT NOT NULL,
	CharacterID INT NOT NULL,
	FOREIGN KEY (RaidLogID) REFERENCES RaidLog (ID),
	FOREIGN KEY (CharacterID) REFERENCES Character (ID),
)


INSERT INTO Raid (Name, PlayerLimit) VALUES ('Molten Core', 40)
INSERT INTO Raid (Name, PlayerLimit) VALUES ('Blackwing Lair', 40)
INSERT INTO Raid (Name, PlayerLimit) VALUES ('Zul''Gurub', 20)
INSERT INTO Raid (Name, PlayerLimit) VALUES ('Ruins of Ahn''Qiraj', 20)
INSERT INTO Raid (Name, PlayerLimit) VALUES ('Temple of Ahn''Qiraj', 40)
INSERT INTO Raid (Name, PlayerLimit) VALUES ('Naxxramas', 40)

INSERT INTO RealmRaid (ReleaseDate, RealmID, RaidID) VALUES ('2019-08-26', (SELECT ID FROM Realm WHERE Name = 'Grobbulus'), (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO RealmRaid (ReleaseDate, RealmID, RaidID) VALUES ('2020-02-12', (SELECT ID FROM Realm WHERE Name = 'Grobbulus'), (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
INSERT INTO RealmRaid (ReleaseDate, RealmID, RaidID) VALUES ('2020-04-15', (SELECT ID FROM Realm WHERE Name = 'Grobbulus'), (SELECT ID FROM Raid WHERE Name = 'Zul''Gurub'))
INSERT INTO RealmRaid (ReleaseDate, RealmID, RaidID) VALUES ('2020-08-20', (SELECT ID FROM Realm WHERE Name = 'Grobbulus'), (SELECT ID FROM Raid WHERE Name = 'Ruins of Ahn''Qiraj'))
INSERT INTO RealmRaid (ReleaseDate, RealmID, RaidID) VALUES ('2020-08-20', (SELECT ID FROM Realm WHERE Name = 'Grobbulus'), (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO RealmRaid (ReleaseDate, RealmID, RaidID) VALUES (NULL, (SELECT ID FROM Realm WHERE Name = 'Grobbulus'), (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))

INSERT INTO Boss (Name, RaidID) VALUES ('Trash', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Lucifron', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Magmadar', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Gehennas', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Garr', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Baron Geddon', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Shazzrah', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Sulfuron Harbinger', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Golemag the Incinerator', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Majordomo Executus', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Ragnaros', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
INSERT INTO Boss (Name, RaidID) VALUES ('Trash', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
INSERT INTO Boss (Name, RaidID) VALUES ('Razorgore the Untamed', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
INSERT INTO Boss (Name, RaidID) VALUES ('Vaelastraz the Corrupt', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
INSERT INTO Boss (Name, RaidID) VALUES ('Broodlord Lashlayer', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
INSERT INTO Boss (Name, RaidID) VALUES ('Firemaw', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
INSERT INTO Boss (Name, RaidID) VALUES ('Ebonroc', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
INSERT INTO Boss (Name, RaidID) VALUES ('Flamegor', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
INSERT INTO Boss (Name, RaidID) VALUES ('Chromaggus', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
INSERT INTO Boss (Name, RaidID) VALUES ('Nefarian', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
INSERT INTO Boss (Name, RaidID) VALUES ('Trash', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO Boss (Name, RaidID) VALUES ('The Prophet Skeram', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO Boss (Name, RaidID) VALUES ('Bug Trio', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO Boss (Name, RaidID) VALUES ('Battleguard Sartura', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO Boss (Name, RaidID) VALUES ('Fankriss the Unyielding', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO Boss (Name, RaidID) VALUES ('Viscidus', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO Boss (Name, RaidID) VALUES ('Princess Huhuran', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO Boss (Name, RaidID) VALUES ('Twin Emperors', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO Boss (Name, RaidID) VALUES ('Ouro', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO Boss (Name, RaidID) VALUES ('C''Thun', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'))
INSERT INTO Boss (Name, RaidID) VALUES ('Trash', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Anub''Rekhan', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Grand Widow Faerlina', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Maexnna', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Noth the Plaguebringer', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Heigan the Unclean', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Loatheb', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Instructor Razuvious', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Gothik the Harvester', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('The Four Horsemen', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Patchwerk', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Grobbulus', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Gluth', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Thaddius', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Sapphiron', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
INSERT INTO Boss (Name, RaidID) VALUES ('Kel''Thuzad', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))

INSERT INTO RaidLog (Name, RaidID, TeamID, StartDate, EndDate) VALUES ('Purple AQ 2020-09-23', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), '2020-09-23 18:00:00', '2020-09-23 20:00:00')
INSERT INTO RaidLog (Name, RaidID, TeamID, StartDate, EndDate) VALUES ('Purple BWL 2020-09-27', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), '2020-09-27 18:00:00', '2020-09-27 19:00:00')
INSERT INTO RaidLog (Name, RaidID, TeamID, StartDate, EndDate) VALUES ('Purple MC 2020-09-27', (SELECT ID FROM Raid WHERE Name = 'Molten Core'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), '2020-09-27 19:00:00', '2020-09-27 20:00:00')

INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple AQ 2020-09-23'), (SELECT ID FROM Character WHERE Name = 'Zoey'))
INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple BWL 2020-09-27'), (SELECT ID FROM Character WHERE Name = 'Zoey'))
INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple MC 2020-09-27'), (SELECT ID FROM Character WHERE Name = 'Zoey'))
INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple AQ 2020-09-23'), (SELECT ID FROM Character WHERE Name = 'Parabella'))
INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple BWL 2020-09-27'), (SELECT ID FROM Character WHERE Name = 'Bellafrost'))
INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple MC 2020-09-27'), (SELECT ID FROM Character WHERE Name = 'Parabella'))


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


--------------------------------
--            ITEM            --
--------------------------------

CREATE TABLE Slot (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NOT NULL,
)

CREATE TABLE SlotClassWeight (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	SlotID INT NOT NULL,
	ClassID INT NOT NULL,
	Weight FLOAT NOT NULL,
	FOREIGN KEY (SlotID) REFERENCES Slot (ID),
	FOREIGN KEY (ClassID) REFERENCES Class (ID),
)

CREATE TABLE Item (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NOT NULL,
	Level INT NULL,
	SlotID INT NULL,
	IsQuestItem BIT NOT NULL,
	RewardFromQuestItem INT NULL,
	FOREIGN KEY (SlotID) REFERENCES Slot (ID),
	FOREIGN KEY (RewardFromQuestItem) REFERENCES Item (ID),
)

CREATE TABLE ItemClassWeight (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	ItemID INT NOT NULL,
	ClassID INT NOT NULL,
	Weight FLOAT NOT NULL,
	FOREIGN KEY (ItemID) REFERENCES Item (ID),
	FOREIGN KEY (ClassID) REFERENCES Class (ID),
)


INSERT INTO Slot (Name) VALUES ('Head')
INSERT INTO Slot (Name) VALUES ('Neck')
INSERT INTO Slot (Name) VALUES ('Shoulders')
INSERT INTO Slot (Name) VALUES ('Back')
INSERT INTO Slot (Name) VALUES ('Chest')
INSERT INTO Slot (Name) VALUES ('Wrist')
INSERT INTO Slot (Name) VALUES ('Hands')
INSERT INTO Slot (Name) VALUES ('Waist')
INSERT INTO Slot (Name) VALUES ('Legs')
INSERT INTO Slot (Name) VALUES ('Feet')
INSERT INTO Slot (Name) VALUES ('Finger')
INSERT INTO Slot (Name) VALUES ('Trinket')
INSERT INTO Slot (Name) VALUES ('One Hand')
INSERT INTO Slot (Name) VALUES ('Two Hand')
INSERT INTO Slot (Name) VALUES ('Main Hand')
INSERT INTO Slot (Name) VALUES ('Off Hand')
INSERT INTO Slot (Name) VALUES ('Ranged')

INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Head'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Neck'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Shoulders'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Back'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Chest'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Wrist'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Hands'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Waist'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Legs'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Feet'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Finger'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Trinket'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.25)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'One Hand'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Two Hand'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Main Hand'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Off Hand'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Ranged'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.25)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Head'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Neck'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Shoulders'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Back'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Chest'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Wrist'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Hands'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Waist'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Legs'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Feet'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Finger'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Trinket'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.25)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'One Hand'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Two Hand'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Main Hand'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Off Hand'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Ranged'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.25)

INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Eye of C''Thun', NULL, NULL, 1, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Ring of the Fallen God', 88, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, (SELECT ID FROM Item WHERE Name = 'Eye of C''Thun'))

INSERT INTO ItemClassWeight (ItemID, ClassID, Weight) VALUES ((SELECT ID FROM Item WHERE Name = 'Ring of the Fallen God'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.0)
INSERT INTO ItemClassWeight (ItemID, ClassID, Weight) VALUES ((SELECT ID FROM Item WHERE Name = 'Ring of the Fallen God'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.2)


SELECT i.Name, i.Level, s.Name, i.IsQuestItem, i2.Name, c.Name, scw.Weight SlotWeight, icw.Weight ClassWeight
FROM Item i
LEFT JOIN Slot s
ON i.SlotID = s.ID
LEFT JOIN Item i2
ON i.RewardFromQuestItem = i2.ID
LEFT JOIN SlotClassWeight scw
ON scw.SlotID = s.ID
LEFT JOIN Class c
ON c.ID = scw.ClassID
LEFT JOIN ItemClassWeight icw
ON icw.ItemID = i.ID AND c.ID = icw.ClassID
