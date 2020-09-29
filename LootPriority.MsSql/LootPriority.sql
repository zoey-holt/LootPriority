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
	Name VARCHAR(100) NOT NULL UNIQUE,
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

CREATE TABLE BossLoot (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	BossID INT NOT NULL,
	ItemID INT NOT NULL,
	DropChance FLOAT NOT NULL,
	FOREIGN KEY (BossID) REFERENCES Boss (ID),
	FOREIGN KEY (ItemID) REFERENCES Item (ID),
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

INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Sharpened Silithid Femur', 78, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Eye of C''Thun', NULL, NULL, 1, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Ring of the Fallen God', 88, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, (SELECT ID FROM Item WHERE Name = 'Eye of C''Thun'))
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Husk of the Old God', NULL, NULL, 1, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Doomcaller''s Robes', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Husk of the Old God'))
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Enigma Robes', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Husk of the Old God'))
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Genesis Vest', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Husk of the Old God'))
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Vestments of the Oracle', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Husk of the Old God'))
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Carapace of the Old God', NULL, NULL, 1, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Avenger''s Breastplate', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'))
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Conqueror''s Breastplate', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'))
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Deathdealer''s Vest', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'))
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Stormcaller''s Hauberk', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'))
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Striker''s Hauberk', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'))
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Cloak of Clarity', 88, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Eyestalk Waist Cord', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Gauntlets of Annihilation', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Ring of the Godslayer', 88, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Cloak of the Devoured', 88, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Mark of C''Thun', 88, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Dark Storm Gauntlets', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Grasp of the Old God', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Belt of Never-ending Agony', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Vanquished Tentacle of C''Thun', 88, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Scepter of the False Prophet', 84, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Dark Edge of Insanity', 84, (SELECT ID FROM Slot WHERE Name = 'Two Hand'), 0, NULL)
INSERT INTO Item (Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES ('Death''s Sting', 84, (SELECT ID FROM Slot WHERE Name = 'One Hand'), 0, NULL)

INSERT INTO ItemClassWeight (ItemID, ClassID, Weight) VALUES ((SELECT ID FROM Item WHERE Name = 'Ring of the Fallen God'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.0)
INSERT INTO ItemClassWeight (ItemID, ClassID, Weight) VALUES ((SELECT ID FROM Item WHERE Name = 'Ring of the Fallen God'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.2)

INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Sharpened Silithid Femur'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Eye of C''Thun'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Husk of the Old God'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Cloak of Clarity'), 0.37)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Eyestalk Waist Cord'), 0.37)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Gauntlets of Annihilation'), 0.35)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Ring of the Godslayer'), 0.35)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Cloak of the Devoured'), 0.32)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Mark of C''Thun'), 0.31)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Dark Storm Gauntlets'), 0.30)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Grasp of the Old God'), 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Belt of Never-ending Agony'), 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Vanquished Tentacle of C''Thun'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Scepter of the False Prophet'), 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Dark Edge of Insanity'), 0.13)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'C''Thun'), (SELECT ID FROM Item WHERE Name = 'Death''s Sting'), 0.11)

SELECT * FROM (
SELECT 
	i.Name Item, 
	i.Level ItemLevel, 
	s.Name Slot, 
	CASE 
		WHEN r.Name IS NULL THEN r2.Name
		ELSE r.Name
	END Raid, 
	CASE 
		WHEN b.Name IS NULL THEN b2.Name
		ELSE b.Name
	END Boss, 
	CASE 
		WHEN bl.DropChance IS NULL THEN bl2.DropChance
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
ORDER BY Raid ASC, Boss ASC, Item ASC
