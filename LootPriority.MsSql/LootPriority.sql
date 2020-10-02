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
	Name VARCHAR(100) NOT NULL UNIQUE,
)

CREATE TABLE Team (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NOT NULL,
)

CREATE TABLE Realm (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	Name VARCHAR(100) NOT NULL UNIQUE,
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
INSERT INTO Boss (Name, RaidID) VALUES ('Golemagg the Incinerator', (SELECT ID FROM Raid WHERE Name = 'Molten Core'))
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
	[Weight] FLOAT NOT NULL,
	FOREIGN KEY (SlotID) REFERENCES Slot (ID),
	FOREIGN KEY (ClassID) REFERENCES Class (ID),
)

CREATE TABLE Item (
	ID INT PRIMARY KEY,
	[Name] VARCHAR(100) NOT NULL UNIQUE,
	[Level] INT NULL,
	SlotID INT NULL,
	IsQuestItem BIT NOT NULL,
	RewardFromQuestItem INT NULL,
	FOREIGN KEY (SlotID) REFERENCES Slot (ID),
	FOREIGN KEY (RewardFromQuestItem) REFERENCES Item (ID),
)

CREATE TABLE ItemClass (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	ItemID INT NULL,
	ClassID INT NULL,
	FOREIGN KEY (ItemID) REFERENCES Item (ID),
	FOREIGN KEY (ClassID) REFERENCES Class (ID),
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

CREATE TABLE CharacterLoot (
	ID INT PRIMARY KEY IDENTITY (1, 1),
	CharacterID INT NOT NULL,
	ItemID INT NOT NULL,
	[Date] DATETIME NOT NULL,
	FOREIGN KEY (CharacterID) REFERENCES Character (ID),
	FOREIGN KEY (ItemID) REFERENCES Item (ID),
)


INSERT INTO Slot (Name) VALUES ('Head')
INSERT INTO Slot (Name) VALUES ('Neck')
INSERT INTO Slot (Name) VALUES ('Shoulder')
INSERT INTO Slot (Name) VALUES ('Back')
INSERT INTO Slot (Name) VALUES ('Chest')
INSERT INTO Slot (Name) VALUES ('Wrist')
INSERT INTO Slot (Name) VALUES ('Hands')
INSERT INTO Slot (Name) VALUES ('Waist')
INSERT INTO Slot (Name) VALUES ('Legs')
INSERT INTO Slot (Name) VALUES ('Feet')
INSERT INTO Slot (Name) VALUES ('Finger')
INSERT INTO Slot (Name) VALUES ('Trinket')
INSERT INTO Slot (Name) VALUES ('One-Hand')
INSERT INTO Slot (Name) VALUES ('Two-Hand')
INSERT INTO Slot (Name) VALUES ('Main Hand')
INSERT INTO Slot (Name) VALUES ('Off Hand')
INSERT INTO Slot (Name) VALUES ('Ranged')

INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Head'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Neck'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Shoulder'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Back'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Chest'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Wrist'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Hands'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Waist'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Legs'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Feet'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Finger'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Trinket'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.25)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'One-Hand'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Two-Hand'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Main Hand'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Off Hand'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Ranged'), (SELECT ID FROM Class WHERE Name = 'Mage'), 0.25)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Head'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Neck'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Shoulder'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Back'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Chest'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Wrist'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Hands'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Waist'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Legs'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.0)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Feet'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Finger'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Trinket'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.25)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'One-Hand'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Two-Hand'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Main Hand'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.5)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Off Hand'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.75)
INSERT INTO SlotClassWeight (SlotID, ClassID, Weight) VALUES ((SELECT ID FROM Slot WHERE Name = 'Ranged'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 0.25)

--DELETE FROM BossLoot;
--DELETE FROM ItemClass;
--DELETE FROM CharacterLoot;
--DELETE FROM Item;

-- Shared AQ40
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21237, 'Imperial Qiraji Regalia', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21273, 'Blessed Qiraji Acolyte Staff', 79, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Regalia'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21275, 'Blessed Qiraji Augur Staff', 79, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Regalia'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21268, 'Blessed Qiraji War Hammer', 79, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Regalia'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21232, 'Imperial Qiraji Armaments', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21242, 'Blessed Qiraji War Axe', 79, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21272, 'Blessed Qiraji Musket', 79, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21244, 'Blessed Qiraji Pugio', 79, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21269, 'Blessed Qiraji Bulwark', 79, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (20932, 'Qiraji Bindings of Dominance', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21388, 'Avenger''s Greaves', 78, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21338, 'Doomcaller''s Footwraps', 78, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21344, 'Enigma Boots', 78, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21355, 'Genesis Boots', 78, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21373, 'Stormcaller''s Footguards', 78, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21391, 'Avenger''s Pauldrons', 78, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21335, 'Doomcaller''s Mantle', 78, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21345, 'Enigma Shoulderpads', 78, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21354, 'Genesis Shoulderpads', 78, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21376, 'Stormcaller''s Pauldrons', 78, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (20928, 'Qiraji Bindings of Command', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21333, 'Conqueror''s Greaves', 78, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Command'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21359, 'Deathdealer''s Boots', 78, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Command'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21349, 'Footwraps of the Oracle', 78, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Command'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21365, 'Striker''s Footguards', 78, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Command'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21330, 'Conqueror''s Spaulders', 78, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Command'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21361, 'Deathdealer''s Spaulders', 78, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Command'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21350, 'Mantle of the Oracle', 78, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Command'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21367, 'Striker''s Pauldrons', 78, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Command'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Qiraji Bindings of Dominance'), (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Qiraji Bindings of Dominance'), (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Qiraji Bindings of Dominance'), (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Qiraji Bindings of Dominance'), (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Qiraji Bindings of Dominance'), (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Avenger''s Greaves'), (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Doomcaller''s Footwraps'), (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Enigma Boots'), (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Genesis Boots'), (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Stormcaller''s Footguards'), (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Avenger''s Pauldrons'), (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Doomcaller''s Mantle'), (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Enigma Shoulderpads'), (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Genesis Shoulderpads'), (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Stormcaller''s Pauldrons'), (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Qiraji Bindings of Command'), (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Qiraji Bindings of Command'), (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Qiraji Bindings of Command'), (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Qiraji Bindings of Command'), (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Conqueror''s Greaves'), (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Deathdealer''s Boots'), (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Footwraps of the Oracle'), (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Striker''s Footguards'), (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Conqueror''s Spaulders'), (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Deathdealer''s Spaulders'), (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Mantle of the Oracle'), (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Striker''s Pauldrons'), (SELECT ID FROM Class WHERE [Name] = 'Hunter'))

-- The Prophet Skeram
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21706, 'Boots of the Unwavering Will', 73, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21699, 'Barrage Shoulders', 73, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21708, 'Beetle Scaled Wristguards', 73, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21701, 'Cloak of Concentrated Hatred', 73, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21698, 'Leggings of Immersion', 73, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21814, 'Breastplate of Annihilation', 73, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21700, 'Pendant of the Qiraji Guardian', 73, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21707, 'Ring of Swarming Thought', 73, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21702, 'Amulet of Foul Warding', 73, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21704, 'Boots of the Redeemed Prophecy', 73, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21703, 'Hammer of Ji''zhi', 73, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21128, 'Staff of the Qiraji Prophets', 75, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21705, 'Boots of the Fallen Prophet', 73, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Boots of the Unwavering Will'), 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Barrage Shoulders'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Beetle Scaled Wristguards'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Cloak of Concentrated Hatred'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Leggings of Immersion'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Breastplate of Annihilation'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Pendant of the Qiraji Guardian'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Ring of Swarming Thought'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Amulet of Foul Warding'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Boots of the Redeemed Prophecy'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Hammer of Ji''zhi'), 0.12)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Staff of the Qiraji Prophets'), 0.12)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Prophet Skeram'), (SELECT ID FROM Item WHERE Name = 'Boots of the Fallen Prophet'), 0.22)

-- Bug Trio
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21682, 'Bile-Covered Gauntlets', 78, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21687, 'Ukko''s Ring of Darkness', 76, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21686, 'Mantle of Phrenic Power', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21696, 'Robes of the Triumvirate', 75, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21697, 'Cape of the Trinity', 75, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21693, 'Guise of the Devourer', 75, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21692, 'Triad Girdle', 75, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21695, 'Angelista''s Touch', 75, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21683, 'Mantle of the Desert Crusade', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21694, 'Ternary Mantle', 75, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21684, 'Mantle of the Desert''s Fury', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21688, 'Boots of the Fallen Hero', 75, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21690, 'Angelista''s Charm', 75, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21691, 'Ooze-ridden Gauntlets', 75, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21689, 'Gloves of Ebru', 75, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21680, 'Vest of Swift Execution', 78, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21603, 'Wand of Qiraji Nobility', 78, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21685, 'Petrified Scarab', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21681, 'Ring of the Devoured', 78, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Bile-Covered Gauntlets'), 0.30)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Ukko''s Ring of Darkness'), 0.30)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Mantle of Phrenic Power'), 0.28)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Robes of the Triumvirate'), 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Cape of the Trinity'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Guise of the Devourer'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Triad Girdle'), 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Angelista''s Touch'), 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Mantle of the Desert Crusade'), 0.36)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Ternary Mantle'), 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Mantle of the Desert''s Fury'), 0.36)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Boots of the Fallen Hero'), 0.33)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Angelista''s Charm'), 0.32)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Ooze-ridden Gauntlets'), 0.31)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Gloves of Ebru'), 0.30)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Vest of Swift Execution'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Wand of Qiraji Nobility'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Petrified Scarab'), 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Ring of the Devoured'), 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'), 0.09)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Bug Trio'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Regalia'), 0.09)

-- Battleguard Sartura
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21671, 'Robes of the Battleguard', 76, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21674, 'Gauntlets of Steadfast Determination', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21676, 'Leggings of the Festering Swarm', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21678, 'Necklace of Purity', 76, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21648, 'Recomposed Boots', 76, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21675, 'Thick Qirajihide Belt', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21669, 'Creeping Vine Helm', 76, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21672, 'Gloves of Enforcement', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21670, 'Badge of the Swarmguard', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21667, 'Legplates of Blazing Light', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21666, 'Sartura''s Might', 76, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21673, 'Silithid Claw', 76, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21668, 'Scaled Leggings of Qiraji Fury', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Robes of the Battleguard'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Gauntlets of Steadfast Determination'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Leggings of the Festering Swarm'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Necklace of Purity'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Recomposed Boots'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Thick Qirajihide Belt'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Creeping Vine Helm'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Gloves of Enforcement'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Badge of the Swarmguard'), 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Legplates of Blazing Light'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Sartura''s Might'), 0.12)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Silithid Claw'), 0.11)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Scaled Leggings of Qiraji Fury'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'), 0.08)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Battleguard Sartura'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Regalia'), 0.07)


-- Fankriss the Unyielding
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21663, 'Robes of the Guardian Saint', 77, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21665, 'Mantle of Wicked Revenge', 77, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21652, 'Silithid Carapace Chestguard', 77, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21664, 'Barbed Choker', 77, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21627, 'Cloak of Untold Secrets', 77, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21647, 'Fetish of the Sand Reaver', 77, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21645, 'Hive Tunneler''s Boots', 77, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21639, 'Pauldrons of the Unrelenting', 77, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21651, 'Scaled Sand Reaver Leggings', 77, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21635, 'Barb of the Sand Reaver', 77, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22402, 'Libram of Grace', 78, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21650, 'Ancient Qiraji Ripper', 77, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22396, 'Totem of Life', 78, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Robes of the Guardian Saint'), 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Mantle of Wicked Revenge'), 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Silithid Carapace Chestguard'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Barbed Choker'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Cloak of Untold Secrets'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Fetish of the Sand Reaver'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Hive Tunneler''s Boots'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Pauldrons of the Unrelenting'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Scaled Sand Reaver Leggings'), 0.13)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Barb of the Sand Reaver'), 0.12)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Libram of Grace'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Ancient Qiraji Ripper'), 0.11)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Totem of Life'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'), 0.08)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Fankriss the Unyielding'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Regalia'), 0.07)

-- Viscidus
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22399, 'Idol of Health', 78, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21677, 'Ring of the Qiraji Fury', 78, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21624, 'Gauntlets of Kalimdor', 78, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21626, 'Slime-coated Leggings', 78, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21622, 'Sharpened Silithid Femur', 78, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21625, 'Scarab Brooch', 78, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Command'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Idol of Health'), 0.26)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Ring of the Qiraji Fury'), 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Gauntlets of Kalimdor'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Slime-coated Leggings'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Sharpened Silithid Femur'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Scarab Brooch'), 0.17)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'), 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Viscidus'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Regalia'), 0.09)

-- Princess Huhuran
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21618, 'Hive Defiler Wristguards', 78, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21617, 'Wasphide Gauntlets', 78, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21620, 'Ring of the Martyr', 78, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21621, 'Cloak of the Golden Hive', 78, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21619, 'Gloves of the Messiah', 78, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21616, 'Huhuran''s Stinger', 78, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Princess Huhuran'), (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Dominance'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Princess Huhuran'), (SELECT ID FROM Item WHERE Name = 'Qiraji Bindings of Command'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Princess Huhuran'), (SELECT ID FROM Item WHERE Name = 'Hive Defiler Wristguards'), 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Princess Huhuran'), (SELECT ID FROM Item WHERE Name = 'Wasphide Gauntlets'), 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Princess Huhuran'), (SELECT ID FROM Item WHERE Name = 'Ring of the Martyr'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Princess Huhuran'), (SELECT ID FROM Item WHERE Name = 'Cloak of the Golden Hive'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Princess Huhuran'), (SELECT ID FROM Item WHERE Name = 'Gloves of the Messiah'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Princess Huhuran'), (SELECT ID FROM Item WHERE Name = 'Huhuran''s Stinger'), 0.12)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Princess Huhuran'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Regalia'), 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Princess Huhuran'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'), 0.08)

-- Twin Emperors
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (20930, 'Vek''lor''s Diadem', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21387, 'Avenger''s Crown', 81, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, (SELECT ID FROM Item WHERE Name = 'Vek''lor''s Diadem'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21360, 'Deathdealer''s Helm', 81, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, (SELECT ID FROM Item WHERE Name = 'Vek''lor''s Diadem'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21353, 'Genesis Helm', 81, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, (SELECT ID FROM Item WHERE Name = 'Vek''lor''s Diadem'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21372, 'Stormcaller''s Diadem', 81, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, (SELECT ID FROM Item WHERE Name = 'Vek''lor''s Diadem'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21366, 'Striker''s Diadem', 81, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, (SELECT ID FROM Item WHERE Name = 'Vek''lor''s Diadem'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (20926, 'Vek''nilash''s Circlet', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21329, 'Conqueror''s Crown', 81, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, (SELECT ID FROM Item WHERE Name = 'Vek''nilash''s Circlet'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21337, 'Doomcaller''s Circlet', 81, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, (SELECT ID FROM Item WHERE Name = 'Vek''nilash''s Circlet'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21347, 'Enigma Circlet', 81, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, (SELECT ID FROM Item WHERE Name = 'Vek''nilash''s Circlet'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21348, 'Tiara of the Oracle', 81, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, (SELECT ID FROM Item WHERE Name = 'Vek''nilash''s Circlet'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21600, 'Boots of Epiphany', 81, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21598, 'Royal Qiraji Belt', 81, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21599, 'Vek''lor''s Gloves of Devastation', 81, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21602, 'Qiraji Execution Bracers', 81, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21601, 'Ring of Emperor Vek''lor', 81, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21597, 'Royal Scepter of Vek''lor', 81, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21605, 'Gloves of the Hidden Temple', 81, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21609, 'Regenerating Belt of Vek''nilash', 81, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21608, 'Amulet of Vek''nilash', 81, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21604, 'Bracelets of Royal Redemption', 81, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21606, 'Belt of the Fallen Emperor', 81, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21679, 'Kalimdor''s Revenge', 81, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21607, 'Grasp of the Fallen Emperor', 81, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Vek''lor''s Diadem'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Vek''nilash''s Circlet'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Boots of Epiphany'), 0.28)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Royal Qiraji Belt'), 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Vek''lor''s Gloves of Devastation'), 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Qiraji Execution Bracers'), 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Ring of Emperor Vek''lor'), 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Royal Scepter of Vek''lor'), 0.14)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Gloves of the Hidden Temple'), 0.28)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Regenerating Belt of Vek''nilash'), 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Amulet of Vek''nilash'), 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Bracelets of Royal Redemption'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Belt of the Fallen Emperor'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Kalimdor''s Revenge'), 0.13)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Grasp of the Fallen Emperor'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Regalia'), 0.16)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Twin Emperors'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'), 0.16)
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Vek''lor''s Diadem'), (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Vek''lor''s Diadem'), (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Vek''lor''s Diadem'), (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Vek''lor''s Diadem'), (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Vek''lor''s Diadem'), (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Avenger''s Crown'), (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Deathdealer''s Helm'), (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Genesis Helm'), (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Stormcaller''s Diadem'), (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Striker''s Diadem'), (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Vek''nilash''s Circlet'), (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Vek''nilash''s Circlet'), (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Vek''nilash''s Circlet'), (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Vek''nilash''s Circlet'), (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Conqueror''s Crown'), (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Doomcaller''s Circlet'), (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Enigma Circlet'), (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Tiara of the Oracle'), (SELECT ID FROM Class WHERE [Name] = 'Priest'))

-- Ouro
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (20931, 'Skin of the Great Sandworm', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21390, 'Avenger''s Legguards', 81, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, (SELECT ID FROM Item WHERE Name = 'Skin of the Great Sandworm'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21336, 'Doomcaller''s Trousers', 81, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, (SELECT ID FROM Item WHERE Name = 'Skin of the Great Sandworm'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21356, 'Genesis Trousers', 81, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, (SELECT ID FROM Item WHERE Name = 'Skin of the Great Sandworm'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21375, 'Stormcaller''s Leggings', 81, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, (SELECT ID FROM Item WHERE Name = 'Skin of the Great Sandworm'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21368, 'Striker''s Leggings', 81, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, (SELECT ID FROM Item WHERE Name = 'Skin of the Great Sandworm'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (20927, 'Ouro''s Intact Hide', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21332, 'Conqueror''s Legguards', 81, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, (SELECT ID FROM Item WHERE Name = 'Ouro''s Intact Hide'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21362, 'Deathdealer''s Leggings', 81, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, (SELECT ID FROM Item WHERE Name = 'Ouro''s Intact Hide'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21346, 'Enigma Leggings', 81, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, (SELECT ID FROM Item WHERE Name = 'Ouro''s Intact Hide'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21352, 'Trousers of the Oracle', 81, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, (SELECT ID FROM Item WHERE Name = 'Ouro''s Intact Hide'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23557, 'Larvae of the Great Worm', 81, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21615, 'Don Rigoberto''s Lost Hat', 81, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23558, 'The Burrower''s Shell', 81, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21611, 'Burrower Bracers', 81, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23570, 'Jom Gabbar', 81, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21610, 'Wormscale Blocker', 81, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ouro'), (SELECT ID FROM Item WHERE Name = 'Skin of the Great Sandworm'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ouro'), (SELECT ID FROM Item WHERE Name = 'Ouro''s Intact Hide'), 1.0)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ouro'), (SELECT ID FROM Item WHERE Name = 'Larvae of the Great Worm'), 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ouro'), (SELECT ID FROM Item WHERE Name = 'Don Rigoberto''s Lost Hat'), 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ouro'), (SELECT ID FROM Item WHERE Name = 'The Burrower''s Shell'), 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ouro'), (SELECT ID FROM Item WHERE Name = 'Burrower Bracers'), 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ouro'), (SELECT ID FROM Item WHERE Name = 'Jom Gabbar'), 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ouro'), (SELECT ID FROM Item WHERE Name = 'Wormscale Blocker'), 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ouro'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Regalia'), 0.12)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ouro'), (SELECT ID FROM Item WHERE Name = 'Imperial Qiraji Armaments'), 0.08)
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Skin of the Great Sandworm'), (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Skin of the Great Sandworm'), (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Skin of the Great Sandworm'), (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Skin of the Great Sandworm'), (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Skin of the Great Sandworm'), (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Avenger''s Legguards'), (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Doomcaller''s Trousers'), (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Genesis Trousers'), (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Stormcaller''s Leggings'), (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Striker''s Leggings'), (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Ouro''s Intact Hide'), (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Ouro''s Intact Hide'), (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Ouro''s Intact Hide'), (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Ouro''s Intact Hide'), (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Conqueror''s Legguards'), (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Deathdealer''s Leggings'), (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Enigma Leggings'), (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Trousers of the Oracle'), (SELECT ID FROM Class WHERE [Name] = 'Priest'))

-- C'Thun
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21221, 'Eye of C''Thun', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21712, 'Amulet of the Fallen God', 88, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, (SELECT ID FROM Item WHERE Name = 'Eye of C''Thun'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21710, 'Cloak of the Fallen God', 88, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, (SELECT ID FROM Item WHERE Name = 'Eye of C''Thun'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21709, 'Ring of the Fallen God', 88, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, (SELECT ID FROM Item WHERE Name = 'Eye of C''Thun'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (20933, 'Husk of the Old God', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21334, 'Doomcaller''s Robes', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Husk of the Old God'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21343, 'Enigma Robes', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Husk of the Old God'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21357, 'Genesis Vest', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Husk of the Old God'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21351, 'Vestments of the Oracle', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Husk of the Old God'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (20929, 'Carapace of the Old God', NULL, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21389, 'Avenger''s Breastplate', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21331, 'Conqueror''s Breastplate', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21364, 'Deathdealer''s Vest', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21374, 'Stormcaller''s Hauberk', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21370, 'Striker''s Hauberk', 88, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, (SELECT ID FROM Item WHERE Name = 'Carapace of the Old God'))
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21583, 'Cloak of Clarity', 88, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22730, 'Eyestalk Waist Cord', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21581, 'Gauntlets of Annihilation', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21596, 'Ring of the Godslayer', 88, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22731, 'Cloak of the Devoured', 88, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22732, 'Mark of C''Thun', 88, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21585, 'Dark Storm Gauntlets', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21582, 'Grasp of the Old God', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21586, 'Belt of Never-ending Agony', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21579, 'Vanquished Tentacle of C''Thun', 88, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21839, 'Scepter of the False Prophet', 84, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21134, 'Dark Edge of Insanity', 84, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21126, 'Death''s Sting', 84, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
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
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Husk of the Old God'), (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Husk of the Old God'), (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Husk of the Old God'), (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Husk of the Old God'), (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Doomcaller''s Robes'), (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Enigma Robes'), (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Genesis Vest'), (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Vestments of the Oracle'), (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Carapace of the Old God'), (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Carapace of the Old God'), (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Carapace of the Old God'), (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Carapace of the Old God'), (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Carapace of the Old God'), (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Avenger''s Breastplate'), (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Conqueror''s Breastplate'), (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Deathdealer''s Vest'), (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Stormcaller''s Hauberk'), (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES ((SELECT ID FROM Item WHERE [Name] = 'Striker''s Hauberk'), (SELECT ID FROM Class WHERE [Name] = 'Hunter'))


--INSERT INTO ItemClassWeight (ItemID, ClassID, Weight) VALUES ((SELECT ID FROM Item WHERE Name = 'Ring of the Fallen God'), (SELECT ID FROM Class WHERE Name = 'Mage'), 1.0)
--INSERT INTO ItemClassWeight (ItemID, ClassID, Weight) VALUES ((SELECT ID FROM Item WHERE Name = 'Ring of the Fallen God'), (SELECT ID FROM Class WHERE Name = 'Warlock'), 1.2)


--SELECT * FROM (
--SELECT 
--	i.ID ItemID,
--	i.Name Item, 
--	i.Level ItemLevel, 
--	s.Name Slot, 
--	CASE 
--		WHEN r.Name IS NULL THEN r2.Name
--		ELSE r.Name
--	END Raid, 
--	CASE 
--		WHEN b.ID IS NULL THEN b2.ID
--		ELSE b.ID
--	END BossID, 
--	CASE 
--		WHEN b.Name IS NULL THEN b2.Name
--		ELSE b.Name
--	END Boss, 
--	CASE 
--		WHEN bl.DropChance IS NULL THEN bl2.DropChance-- / (SELECT COUNT(*) FROM Item WHERE IsQuestItem = 0 AND RewardFromQuestItem = i2.ID)
--		ELSE bl.DropChance
--	END DropChance
--FROM Item i
--LEFT JOIN Slot s
--ON i.SlotID = s.ID
--LEFT JOIN Item i2
--ON i.RewardFromQuestItem = i2.ID AND i2.IsQuestItem = 1
--LEFT JOIN BossLoot bl
--ON bl.ItemID = i.ID
--LEFT JOIN Boss b
--ON b.ID = bl.BossID
--LEFT JOIN Raid r
--ON b.RaidID = r.ID
--LEFT JOIN BossLoot bl2
--ON bl2.ItemID = i2.ID
--LEFT JOIN Boss b2
--ON b2.ID = bl2.BossID
--LEFT JOIN Raid r2
--ON b2.RaidID = r2.ID
--WHERE i.IsQuestItem = 0) a
--ORDER BY Raid ASC, BossID ASC, DropChance DESC

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



