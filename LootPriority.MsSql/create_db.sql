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
GO

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
GO

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
GO

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
INSERT INTO Boss (Name, RaidID) VALUES ('Vaelastrasz the Corrupt', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'))
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
INSERT INTO Boss (Name, RaidID) VALUES ('Maexxna', (SELECT ID FROM Raid WHERE Name = 'Naxxramas'))
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
GO

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
	[Name] VARCHAR(100) NOT NULL,
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
GO

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
INSERT INTO Slot (Name) VALUES ('Shield')
INSERT INTO Slot (Name) VALUES ('Ranged')
INSERT INTO Slot (Name) VALUES ('Relic')
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
GO


-- MC Shared
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19146, 'Wristguards of Stability', 65, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18878, 'Sorcerous Dagger', 65, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18872, 'Manastorm Leggings', 63, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18875, 'Salamander Scale Pants', 64, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18879, 'Heavy Dark Iron Ring', 66, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17077, 'Crimson Shocker', 63, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19145, 'Robe of Volatile Power', 66, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19147, 'Ring of Spell Power', 66, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18861, 'Flamewaker Legplates', 61, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18870, 'Helm of the Lifegiver', 62, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18821, 'Quick Strike Ring', 67, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19136, 'Mana Igniting Cord', 71, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18823, 'Aged Core Leather Gloves', 69, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18820, 'Talisman of Ephemeral Power', 66, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19143, 'Flameguard Gauntlets', 69, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19142, 'Fire Runed Grimoire', 70, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18822, 'Obsidian Edged Blade', 68, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18824, 'Magma Tempered Boots', 70, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18829, 'Deep Earth Spaulders', 71, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19144, 'Sabatons of the Flamewalker', 68, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
GO
-- MC Trash
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16819, 'Vambraces of Prophecy', 66, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16827, 'Nightslayer Belt', 66, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16817, 'Girdle of Prophecy', 66, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16802, 'Arcanist Belt', 66, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16825, 'Nightslayer Bracelets', 66, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16830, 'Cenarion Bracers', 66, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16861, 'Bracers of Might', 66, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16806, 'Felheart Belt', 66, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16850, 'Giantstalker''s Bracers', 66, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16804, 'Felheart Bracers', 66, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16828, 'Cenarion Belt', 66, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16851, 'Giantstalker''s Belt', 66, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16799, 'Arcanist Bindings', 66, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16864, 'Belt of Might', 66, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16838, 'Earthfury Belt', 66, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16857, 'Lawbringer Bracers', 66, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16858, 'Lawbringer Belt', 66, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16840, 'Earthfury Bracers', 66, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16819, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16827, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16817, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16802, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16825, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16830, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16861, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16806, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16850, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16804, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16828, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16851, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16799, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16864, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16838, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16857, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16858, 0.10)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Molten Core')), 16840, 0.10)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16819, (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16827, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16817, (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16802, (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16825, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16830, (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16861, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16806, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16850, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16804, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16828, (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16851, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16799, (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16864, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16838, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16857, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16858, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16840, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
GO
-- Lucifron
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16805, 'Felheart Gloves', 66, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16863, 'Gauntlets of Might', 66, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17109, 'Choker of Enlightenment', 65, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16800, 'Arcanist Boots', 66, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16837, 'Earthfury Boots', 66, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16859, 'Lawbringer Boots', 66, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16829, 'Cenarion Boots', 66, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 16805, 0.30)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 16863, 0.29)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 17109, 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 16800, 0.23)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 16837, 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 16859, 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 16829, 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 19146, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 18878, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 18872, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 18875, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 18879, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 17077, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 19145, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 19147, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 18861, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Lucifron'), 18870, 0.01)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16805, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16863, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16800, (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16837, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16859, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16829, (SELECT ID FROM Class WHERE [Name] = 'Druid'))
GO
-- Magmadar
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16796, 'Arcanist Leggings', 66, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17069, 'Striker''s Mark', 69, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17073, 'Earthshaker', 66, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18203, 'Eskhandar''s Right Claw', 66, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17065, 'Medallion of Steadfast Might', 68, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16835, 'Cenarion Leggings', 66, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16867, 'Legplates of Might', 66, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16814, 'Pants of Prophecy', 66, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16810, 'Felheart Pants', 66, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16843, 'Earthfury Legguards', 66, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16855, 'Lawbringer Legplates', 66, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16847, 'Giantstalker''s Leggings', 66, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16822, 'Nightslayer Pants', 66, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 16796, 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 17069, 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 17073, 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 18203, 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 17065, 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 16835, 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 16867, 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 16814, 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 16810, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 16843, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 16855, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 16847, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 16822, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 18821, 0.07)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 19136, 0.07)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 18823, 0.07)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 18820, 0.07)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 19143, 0.07)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 19142, 0.06)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 18822, 0.06)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 18861, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 18824, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 18829, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Magmadar'), 19144, 0.03)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16796, (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16835, (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16867, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16814, (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16810, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16843, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16855, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16847, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16822, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
GO
-- Gehennas
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16826, 'Nightslayer Gloves', 66, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16812, 'Gloves of Prophecy', 66, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16839, 'Earthfury Gauntlets', 66, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16860, 'Lawbringer Gauntlets', 66, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16849, 'Giantstalker''s Boots', 66, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16862, 'Sabatons of Might', 66, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 16826, 0.33)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 16812, 0.32)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 16839, 0.32)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 16860, 0.32)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 16849, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 16862, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 18875, 0.06)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 17077, 0.05)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 19147, 0.05)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 18878, 0.05)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 19145, 0.05)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 19146, 0.05)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 18872, 0.05)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 18861, 0.05)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 18879, 0.05)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gehennas'), 18870, 0.02)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16826, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16812, (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16839, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16860, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16849, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16862, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
GO
-- Garr
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17066, 'Drillborer Disk', 67, (SELECT ID FROM Slot WHERE Name = 'Shield'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18832, 'Brutality Blade', 70, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17105, 'Aurastone Hammer', 69, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16842, 'Earthfury Helmet', 66, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16854, 'Lawbringer Helm', 66, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17071, 'Gutgore Ripper', 69, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16821, 'Nightslayer Cover', 66, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16866, 'Helm of Might', 66, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16808, 'Felheart Horns', 66, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16795, 'Arcanist Crown', 66, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16813, 'Circlet of Prophecy', 66, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16846, 'Giantstalker''s Helmet', 66, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16834, 'Cenarion Helm', 66, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 17066, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 18832, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 17105, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 16842, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 16854, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 17071, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 16821, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 16866, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 16808, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 16795, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 16813, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 16846, 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 16834, 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 18823, 0.07)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 19143, 0.06)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 18820, 0.06)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 18821, 0.06)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 19136, 0.06)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 19142, 0.06)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 18822, 0.06)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 18824, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 18861, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 18829, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Garr'), 19144, 0.03)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16842, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16854, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16821, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16866, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16808, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16795, (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16813, (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16846, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16834, (SELECT ID FROM Class WHERE [Name] = 'Druid'))
GO
-- Baron Geddon
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17110, 'Seal of the Archmagus', 70, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16797, 'Arcanist Mantle', 66, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16807, 'Felheart Shoulder Pads', 66, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16844, 'Earthfury Epaulets', 66, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16856, 'Lawbringer Spaulders', 66, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16836, 'Cenarion Spaulders', 66, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 17110, 0.32)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 16797, 0.31)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 16807, 0.31)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 16844, 0.31)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 16856, 0.31)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 16836, 0.31)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 18823, 0.04)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 18820, 0.04)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 18822, 0.04)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 18821, 0.04)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 19142, 0.04)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 19136, 0.04)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 19143, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 18824, 0.02)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 18861, 0.02)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 19144, 0.02)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Baron Geddon'), 18829, 0.02)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16797, (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16807, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16844, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16856, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16836, (SELECT ID FROM Class WHERE [Name] = 'Druid'))
GO
-- Shazzrah
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16852, 'Giantstalker''s Gloves', 66, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16801, 'Arcanist Gloves', 66, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16831, 'Cenarion Gloves', 66, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16803, 'Felheart Slippers', 66, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16824, 'Nightslayer Boots', 66, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16811, 'Boots of Prophecy', 66, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 16852, 0.32)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 16801, 0.32)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 16831, 0.32)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 16803, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 16824, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 16811, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 17077, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 18879, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 18872, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 19147, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 18861, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 19145, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 18875, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 18878, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 19146, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Shazzrah'), 18870, 0.01)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16852, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16801, (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16831, (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16803, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16824, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16811, (SELECT ID FROM Class WHERE [Name] = 'Priest'))
GO
-- Sulfuron Harbinger
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17074, 'Shadowstrike', 63, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16868, 'Pauldrons of Might', 66, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16848, 'Giantstalker''s Epaulets', 66, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16823, 'Nightslayer Shoulder Pads', 66, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16816, 'Mantle of Prophecy', 66, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 17074, 0.33)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 16868, 0.33)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 16848, 0.33)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 16823, 0.33)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 16816, 0.33)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 18878, 0.04)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 18879, 0.04)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 18872, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 19147, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 18875, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 17077, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 19146, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sulfuron Harbinger'), 18861, 0.03)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16868, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16848, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16823, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16816, (SELECT ID FROM Class WHERE [Name] = 'Priest'))
GO
-- Golemagg the Incinerator
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17103, 'Azuresong Mageblade', 71, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16798, 'Arcanist Robes', 66, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16841, 'Earthfury Vestments', 66, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16853, 'Lawbringer Chestguard', 66, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18842, 'Staff of Dominance', 70, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16820, 'Nightslayer Chestpiece', 66, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16845, 'Giantstalker''s Breastplate', 66, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17072, 'Blastershot Launcher', 70, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16865, 'Breastplate of Might', 66, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16815, 'Robes of Prophecy', 66, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16809, 'Felheart Robes', 66, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16833, 'Cenarion Vestments', 66, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 17103, 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 16798, 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 16841, 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 16853, 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 18842, 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 16820, 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 16845, 0.25)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 17072, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 16865, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 16815, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 16809, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 16833, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 18822, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 18823, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 19143, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 18820, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 19136, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 18821, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 19142, 0.03)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 18824, 0.01)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 18861, 0.01)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 18829, 0.01)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Golemagg the Incinerator'), 19144, 0.01)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16798, (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16841, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16853, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16820, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16845, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16865, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16815, (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16809, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16833, (SELECT ID FROM Class WHERE [Name] = 'Druid'))
GO
-- Majordomo Executus
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18646, 'The Eye of Divinity', 71, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18608, 'Benediction', 75, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, 18646)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18609, 'Anathema', 75, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, 18646)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18703, 'Ancient Petrified Leaf', 71, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18713, 'Rhok''delar, Longbow of the Ancient Keepers', 75, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, 18703)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18715, 'Lok''delar, Stave of the Ancient Keepers', 75, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, 18703)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18808, 'Gloves of the Hypnotic Flame', 70, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19140, 'Cauterizing Band', 71, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18810, 'Wild Growth Spaulders', 71, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18806, 'Core Forged Greaves', 70, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18805, 'Core Hound Tooth', 70, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18811, 'Fireproof Cloak', 71, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18812, 'Wristguards of True Flight', 71, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18803, 'Finkle''s Lava Dredger', 70, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18809, 'Sash of Whispered Secrets', 71, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19139, 'Fireguard Shoulders', 71, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 18646, 0.50)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 18703, 0.46)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 18808, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 19140, 0.21)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 18810, 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 18806, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 18805, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 18811, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 18812, 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 18803, 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 18809, 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Majordomo Executus'), 19139, 0.15)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (18646, (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (18703, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
GO
-- Ragnaros
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16901, 'Stormrage Legguards', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18815, 'Essence of the Pure Flame', 75, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17102, 'Cloak of the Shrouded Mists', 74, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16915, 'Netherwind Pants', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16930, 'Nemesis Leggings', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16946, 'Legplates of Ten Storms', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16954, 'Judgement Legplates', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18814, 'Choker of the Fire Lord', 78, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19138, 'Band of Sulfuras', 78, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17107, 'Dragon''s Blood Cape', 73, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16962, 'Legplates of Wrath', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16909, 'Bloodfang Pants', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17063, 'Band of Accuria', 78, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18816, 'Perdition''s Blade', 77, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19137, 'Onslaught Girdle', 78, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16922, 'Leggings of Transcendence', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (18817, 'Crown of Destruction', 76, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17106, 'Malistar''s Defender', 75, (SELECT ID FROM Slot WHERE Name = 'Shield'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16938, 'Dragonstalker''s Legguards', 76, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17076, 'Bonereaver''s Edge', 77, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17082, 'Shard of the Flame', 74, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (17104, 'Spinal Reaper', 76, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 16901, 0.27)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 18815, 0.24)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 17102, 0.22)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 16915, 0.20)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 16930, 0.19)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 16946, 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 16954, 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 18814, 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 19138, 0.18)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 17107, 0.17)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 16962, 0.16)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 16909, 0.15)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 17063, 0.15)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 18816, 0.14)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 19137, 0.14)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 16922, 0.12)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 18817, 0.09)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 17106, 0.08)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 16938, 0.07)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 17076, 0.05)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 17082, 0.04)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ragnaros'), 17104, 0.03)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16901, (SELECT ID FROM Class WHERE [Name] = 'Druid'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16915, (SELECT ID FROM Class WHERE [Name] = 'Mage'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16930, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16946, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16954, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16962, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16909, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16922, (SELECT ID FROM Class WHERE [Name] = 'Priest'))
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16938, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))
GO


-- BWL Trash
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19354, 'Draconic Avenger', 71, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19438, 'Ringo''s Blizzard Boots', 71, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19439, 'Interlaced Shadow Jerkin', 71, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19436, 'Cloak of Draconic Might', 70, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19358, 'Draconic Maul', 70, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19437, 'Boots of Pure Thought', 70, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19434, 'Band of Dark Dominion', 70, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19435, 'Essence Gatherer', 70, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19362, 'Doom''s Edge', 70, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair')), 19354, 0.10)--Draconic Avenger
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair')), 19438, 0.10)--Ringo's Blizzard Boots
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair')), 19439, 0.10)--Interlaced Shadow Jerkin
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair')), 19436, 0.10)--Cloak of Draconic Might
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair')), 19358, 0.10)--Draconic Maul
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair')), 19437, 0.10)--Boots of Pure Thought
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair')), 19434, 0.10)--Band of Dark Dominion
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair')), 19435, 0.10)--Essence Gatherer
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair')), 19362, 0.10)--Doom's Edge
GO
-- Razorgore the Untamed
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16911, 'Bloodfang Bracers', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16959, 'Bracelets of Wrath', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16918, 'Netherwind Bindings', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16904, 'Stormrage Bracers', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16934, 'Nemesis Bracers', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16943, 'Bracers of Ten Storms', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16951, 'Judgement Bindings', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16926, 'Bindings of Transcendence', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16935, 'Dragonstalker''s Bracers', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19336, 'Arcane Infused Gem', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19337, 'The Black Book', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19369, 'Gloves of Rapid Evolution', 73, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19370, 'Mantle of the Blackwing Cabal', 73, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19334, 'The Untamed Blade', 73, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19335, 'Spineshatter', 73, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 16911, 0.43)--Bloodfang Bracers
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 16959, 0.43)--Bracelets of Wrath
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 16918, 0.43)--Netherwind Bindings
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 16904, 0.41)--Stormrage Bracers
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 16934, 0.40)--Nemesis Bracers
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 16943, 0.39)--Bracers of Ten Storms
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 16951, 0.39)--Judgement Bindings
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 16926, 0.39)--Bindings of Transcendence
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 16935, 0.38)--Dragonstalker's Bracers
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 19336, 0.36)--Arcane Infused Gem
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 19337, 0.33)--The Black Book
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 19369, 0.20)--Gloves of Rapid Evolution
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 19370, 0.19)--Mantle of the Blackwing Cabal
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 19334, 0.10)--The Untamed Blade
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Razorgore the Untamed'), 19335, 0.09)--Spineshatter
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16911, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bloodfang Bracers
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16959, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Bracelets of Wrath
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16918, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Netherwind Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16904, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Stormrage Bracers
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16934, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Nemesis Bracers
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16943, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Bracers of Ten Storms
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16951, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Judgement Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16926, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Bindings of Transcendence
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16935, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Dragonstalker's Bracers
INSERT INTO ItemClass (ItemID, ClassID) VALUES (19336, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Arcane Infused Gem
INSERT INTO ItemClass (ItemID, ClassID) VALUES (19337, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--The Black Book
GO
-- Vaelastrasz the Corrupt
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16910, 'Bloodfang Belt', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16960, 'Waistband of Wrath', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16818, 'Netherwind Belt', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16903, 'Stormrage Belt', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16933, 'Nemesis Belt', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16944, 'Belt of Ten Storms', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16952, 'Judgement Belt', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16925, 'Belt of Transcendence', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19371, 'Pendant of the Fallen Dragon', 74, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16936, 'Dragonstalker''s Belt', 76, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19339, 'Mind Quickening Gem', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19372, 'Helm of Endless Rage', 74, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19340, 'Rune of Metamorphosis', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19346, 'Dragonfang Blade', 74, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19348, 'Red Dragonscale Protector', 74, (SELECT ID FROM Slot WHERE Name = 'Shield'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 16910, 0.43)--Bloodfang Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 16960, 0.43)--Waistband of Wrath
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 16818, 0.43)--Netherwind Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 16903, 0.41)--Stormrage Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 16933, 0.40)--Nemesis Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 16944, 0.39)--Belt of Ten Storms
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 16952, 0.39)--Judgement Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 16925, 0.39)--Belt of Transcendence
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 19371, 0.38)--Pendant of the Fallen Dragon
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 16936, 0.38)--Dragonstalker's Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 19339, 0.36)--Mind Quickening Gem
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 19372, 0.35)--Helm of Endless Rage
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 19340, 0.33)--Rune of Metamorphosis
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 19346, 0.21)--Dragonfang Blade
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Vaelastrasz the Corrupt'), 19348, 0.17)--Red Dragonscale Protector
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16910, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bloodfang Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16960, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Waistband of Wrath
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16818, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Netherwind Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16903, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Stormrage Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16933, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Nemesis Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16944, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Belt of Ten Storms
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16952, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Judgement Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16925, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Belt of Transcendence
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16936, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Dragonstalker's Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (19339, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Mind Quickening Gem
INSERT INTO ItemClass (ItemID, ClassID) VALUES (19340, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Rune of Metamorphosis
GO
-- Broodlord Lashlayer
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16949, 'Greaves of Ten Storms', 76, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16957, 'Judgement Sabatons', 76, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16912, 'Netherwind Boots', 76, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16965, 'Sabatons of Wrath', 76, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16941, 'Dragonstalker''s Greaves', 76, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16919, 'Boots of Transcendence', 76, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16927, 'Nemesis Boots', 76, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16906, 'Bloodfang Boots', 76, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19373, 'Black Brood Pauldrons', 75, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19342, 'Venomous Totem', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16898, 'Stormrage Boots', 76, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19341, 'Lifegiving Gem', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19374, 'Bracers of Arcane Accuracy', 75, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19350, 'Heartstriker', 75, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19351, 'Maladath, Runed Blade of the Black Flight', 75, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 16949, 0.38)--Greaves of Ten Storms
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 16957, 0.38)--Judgement Sabatons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 16912, 0.36)--Netherwind Boots
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 16965, 0.36)--Sabatons of Wrath
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 16941, 0.35)--Dragonstalker's Greaves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 16919, 0.35)--Boots of Transcendence
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 16927, 0.34)--Nemesis Boots
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 16906, 0.34)--Bloodfang Boots
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 19373, 0.33)--Black Brood Pauldrons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 19342, 0.32)--Venomous Totem
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 16898, 0.30)--Stormrage Boots
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 19341, 0.29)--Lifegiving Gem
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 19374, 0.27)--Bracers of Arcane Accuracy
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 19350, 0.18)--Heartstriker
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Broodlord Lashlayer'), 19351, 0.16)--Maladath, Runed Blade of the Black Flight
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16949, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Greaves of Ten Storms
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16957, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Judgement Sabatons
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16912, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Netherwind Boots
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16965, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Sabatons of Wrath
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16941, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Dragonstalker's Greaves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16919, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Boots of Transcendence
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16927, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Nemesis Boots
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16906, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bloodfang Boots
INSERT INTO ItemClass (ItemID, ClassID) VALUES (19342, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Venomous Totem
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16898, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Stormrage Boots
INSERT INTO ItemClass (ItemID, ClassID) VALUES (19341, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Lifegiving Gem
GO
-- Firemaw
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19399, 'Black Ash Robe', 75, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19400, 'Firemaw''s Clutch', 75, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19365, 'Claw of the Black Drake', 75, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19398, 'Cloak of Firemaw', 75, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19343, 'Scrolls of Blinding Light', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19402, 'Legguards of the Fallen Crusader', 75, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16964, 'Gauntlets of Wrath', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16920, 'Handguards of Transcendence', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19396, 'Taut Dragonhide Belt', 75, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16913, 'Netherwind Gloves', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16940, 'Dragonstalker''s Gauntlets', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19394, 'Drake Talon Pauldrons', 75, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16907, 'Bloodfang Gloves', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16928, 'Nemesis Gloves', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16948, 'Gauntlets of Ten Storms', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16956, 'Judgement Gauntlets', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19397, 'Ring of Blackrock', 75, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16899, 'Stormrage Handguards', 76, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19344, 'Natural Alignment Crystal', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19401, 'Primalist''s Linked Legguards', 75, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19395, 'Rejuvenating Gem', 75, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19355, 'Shadow Wing Focus Staff', 75, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19353, 'Drake Talon Cleaver', 75, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19399, 0.35)--Black Ash Robe
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19400, 0.34)--Firemaw's Clutch
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19365, 0.32)--Claw of the Black Drake
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19398, 0.29)--Cloak of Firemaw
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19343, 0.30)--Scrolls of Blinding Light
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19402, 0.29)--Legguards of the Fallen Crusader
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 16964, 0.16)--Gauntlets of Wrath
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 16920, 0.16)--Handguards of Transcendence
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19396, 0.15)--Taut Dragonhide Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 16913, 0.14)--Netherwind Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 16940, 0.14)--Dragonstalker's Gauntlets
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19394, 0.14)--Drake Talon Pauldrons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 16907, 0.13)--Bloodfang Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 16928, 0.13)--Nemesis Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 16948, 0.13)--Gauntlets of Ten Storms
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 16956, 0.13)--Judgement Gauntlets
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19397, 0.13)--Ring of Blackrock
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 16899, 0.12)--Stormrage Handguards
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19344, 0.30)--Natural Alignment Crystal
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19401, 0.29)--Primalist's Linked Legguards
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19395, 0.11)--Rejuvenating Gem
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19355, 0.07)--Shadow Wing Focus Staff
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Firemaw'), 19353, 0.05)--Drake Talon Cleaver
INSERT INTO ItemClass (ItemID, ClassID) VALUES (19343, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Scrolls of Blinding Light
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16964, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Gauntlets of Wrath
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16920, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Handguards of Transcendence
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16913, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Netherwind Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16940, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Dragonstalker's Gauntlets
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16907, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bloodfang Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16928, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Nemesis Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16948, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Gauntlets of Ten Storms
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16956, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Judgement Gauntlets
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16899, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Stormrage Handguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (19344, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Natural Alignment Crystal
GO
-- Ebonroc
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19345, 'Aegis of Preservation', 76, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19403, 'Band of Forced Concentration', 75, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19406, 'Drake Fang Talisman', 75, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19407, 'Ebony Flame Gloves', 75, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19405, 'Malfurion''s Blessed Bulwark', 75, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19368, 'Dragonbreath Hand Cannon', 75, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19345, 0.41)--Aegis of Preservation
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19403, 0.33)--Band of Forced Concentration
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19406, 0.33)--Drake Fang Talisman
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19407, 0.31)--Ebony Flame Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19405, 0.30)--Malfurion's Blessed Bulwark
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19368, 0.17)--Dragonbreath Hand Cannon
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 16913, 0.16)--Netherwind Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 16964, 0.16)--Gauntlets of Wrath
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 16928, 0.14)--Nemesis Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 16920, 0.14)--Handguards of Transcendence
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 16940, 0.14)--Dragonstalker's Gauntlets
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19397, 0.14)--Ring of Blackrock
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19395, 0.13)--Rejuvenating Gem
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 16899, 0.13)--Stormrage Handguards
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 16907, 0.13)--Bloodfang Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19396, 0.13)--Taut Dragonhide Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19394, 0.10)--Drake Talon Pauldrons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 16956, 0.15)--Judgement Gauntlets
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 16948, 0.15)--Gauntlets of Ten Storms
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19353, 0.09)--Drake Talon Cleaver
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Ebonroc'), 19355, 0.05)--Shadow Wing Focus Staff
INSERT INTO ItemClass (ItemID, ClassID) VALUES (19345, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Aegis of Preservation
GO
-- Flamegor
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19430, 'Shroud of Pure Thought', 75, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19432, 'Circle of Applied Force', 75, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19433, 'Emberweave Leggings', 75, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19431, 'Styleen''s Impeding Scarab', 75, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19367, 'Dragon''s Touch', 75, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19357, 'Herald of Woe', 75, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19430, 0.44)--Shroud of Pure Thought
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19432, 0.38)--Circle of Applied Force
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19433, 0.35)--Emberweave Leggings
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19431, 0.32)--Styleen's Impeding Scarab
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19367, 0.20)--Dragon's Touch
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19357, 0.20)--Herald of Woe
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19396, 0.18)--Taut Dragonhide Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 16948, 0.18)--Gauntlets of Ten Storms
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 16956, 0.18)--Judgement Gauntlets
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 16920, 0.16)--Handguards of Transcendence
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 16913, 0.15)--Netherwind Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 16964, 0.15)--Gauntlets of Wrath
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 16907, 0.14)--Bloodfang Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 16899, 0.13)--Stormrage Handguards
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 16940, 0.13)--Dragonstalker's Gauntlets
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19395, 0.12)--Rejuvenating Gem
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19397, 0.12)--Ring of Blackrock
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 16928, 0.12)--Nemesis Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19394, 0.11)--Drake Talon Pauldrons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19355, 0.06)--Shadow Wing Focus Staff
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Flamegor'), 19353, 0.05)--Drake Talon Cleaver
GO
-- Chromaggus
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16917, 'Netherwind Mantle', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16937, 'Dragonstalker''s Spaulders', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16945, 'Epaulets of Ten Storms', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16953, 'Judgement Spaulders', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16961, 'Pauldrons of Wrath', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16924, 'Pauldrons of Transcendence', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16832, 'Bloodfang Spaulders', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19389, 'Taut Dragonhide Shoulderpads', 77, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19388, 'Angelista''s Grasp', 77, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16932, 'Nemesis Spaulders', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19390, 'Taut Dragonhide Gloves', 77, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16902, 'Stormrage Pauldrons', 76, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19387, 'Chromatic Boots', 77, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19391, 'Shimmering Geta', 77, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19386, 'Elementium Threaded Cloak', 77, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19385, 'Empowered Leggings', 77, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19392, 'Girdle of the Fallen Crusader', 77, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19347, 'Claw of Chromaggus', 77, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19352, 'Chromatically Tempered Sword', 77, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19361, 'Ashjre''thul, Crossbow of Smiting', 77, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19393, 'Primalist''s Linked Waistguard', 77, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19349, 'Elementium Reinforced Bulwark', 77, (SELECT ID FROM Slot WHERE Name = 'Shield'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 16917, 0.42)--Netherwind Mantle
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 16937, 0.40)--Dragonstalker's Spaulders
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 16945, 0.40)--Epaulets of Ten Storms
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 16953, 0.40)--Judgement Spaulders
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 16961, 0.40)--Pauldrons of Wrath
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 16924, 0.39)--Pauldrons of Transcendence
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 16832, 0.38)--Bloodfang Spaulders
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19389, 0.37)--Taut Dragonhide Shoulderpads
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19388, 0.37)--Angelista's Grasp
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 16932, 0.36)--Nemesis Spaulders
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19390, 0.36)--Taut Dragonhide Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 16902, 0.36)--Stormrage Pauldrons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19387, 0.36)--Chromatic Boots
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19391, 0.34)--Shimmering Geta
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19386, 0.33)--Elementium Threaded Cloak
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19385, 0.32)--Empowered Leggings
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19392, 0.24)--Girdle of the Fallen Crusader
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19347, 0.18)--Claw of Chromaggus
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19352, 0.17)--Chromatically Tempered Sword
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19361, 0.17)--Ashjre'thul, Crossbow of Smiting
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19393, 0.16)--Primalist's Linked Waistguard
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Chromaggus'), 19349, 0.15)--Elementium Reinforced Bulwark
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16917, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Netherwind Mantle
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16937, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Dragonstalker's Spaulders
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16945, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Epaulets of Ten Storms
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16953, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Judgement Spaulders
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16961, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Pauldrons of Wrath
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16924, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Pauldrons of Transcendence
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16832, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bloodfang Spaulders
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16932, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Nemesis Spaulders
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16902, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Stormrage Pauldrons
GO
-- Nefarian
--INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19002, 'Head of Nefarian', 60, NULL, 1, NULL)--Horde
--INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16916, 'Master Dragonslayer''s Medallion', 83, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, 19002)
--INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16916, 'Master Dragonslayer''s Orb', 83, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, 19002)
--INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16916, 'Master Dragonslayer''s Ring', 83, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, 19002)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19003, 'Head of Nefarian', 60, NULL, 1, NULL)--Alliance
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19383, 'Master Dragonslayer''s Medallion', 83, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, 19003)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19366, 'Master Dragonslayer''s Orb', 83, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, 19003)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19384, 'Master Dragonslayer''s Ring', 83, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, 19003)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16916, 'Netherwind Robes', 76, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16942, 'Dragonstalker''s Breastplate', 76, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19378, 'Cloak of the Brood Lord', 83, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16966, 'Breastplate of Wrath', 76, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19380, 'Therazane''s Link', 83, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16905, 'Bloodfang Chestpiece', 76, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16923, 'Robes of Transcendence', 76, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16950, 'Breastplate of Ten Storms', 76, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16958, 'Judgement Breastplate', 76, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19381, 'Boots of the Shadow Flame', 83, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19376, 'Archimtiros'' Ring of Reckoning', 83, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16931, 'Nemesis Robes', 76, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (16897, 'Stormrage Chestguard', 76, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19379, 'Neltharion''s Tear', 83, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19382, 'Pure Elementium Band', 83, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19377, 'Prestor''s Talisman of Connivery', 83, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19375, 'Mish''undare, Circlet of the Mind Flayer', 83, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19356, 'Staff of the Shadow Flame', 81, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19364, 'Ashkandi, Greatsword of the Brotherhood', 81, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19360, 'Lok''amir il Romathis', 81, (SELECT ID FROM Slot WHERE Name = 'Main Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (19363, 'Crul''shorukh, Edge of Chaos', 81, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
--INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19002, 1.00)--Head of Nefarian
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19003, 1.00)--Head of Nefarian
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 16916, 0.37)--Netherwind Robes
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 16942, 0.36)--Dragonstalker's Breastplate
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19378, 0.35)--Cloak of the Brood Lord
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 16966, 0.34)--Breastplate of Wrath
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19380, 0.34)--Therazane's Link
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 16905, 0.33)--Bloodfang Chestpiece
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 16923, 0.33)--Robes of Transcendence
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 16950, 0.32)--Breastplate of Ten Storms
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 16958, 0.32)--Judgement Breastplate
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19381, 0.32)--Boots of the Shadow Flame
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19376, 0.32)--Archimtiros' Ring of Reckoning
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 16931, 0.32)--Nemesis Robes
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 16897, 0.31)--Stormrage Chestguard
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19379, 0.30)--Neltharion's Tear
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19382, 0.30)--Pure Elementium Band
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19377, 0.29)--Prestor's Talisman of Connivery
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19375, 0.29)--Mish'undare, Circlet of the Mind Flayer
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19356, 0.17)--Staff of the Shadow Flame
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19364, 0.14)--Ashkandi, Greatsword of the Brotherhood
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19360, 0.14)--Lok'amir il Romathis
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Nefarian'), 19363, 0.14)--Crul'shorukh, Edge of Chaos
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16916, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Netherwind Robes
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16942, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Dragonstalker's Breastplate
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16966, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Breastplate of Wrath
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16905, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bloodfang Chestpiece
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16923, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Robes of Transcendence
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16950, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Breastplate of Ten Storms
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16958, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Judgement Breastplate
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16931, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Nemesis Robes
INSERT INTO ItemClass (ItemID, ClassID) VALUES (16897, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Stormrage Chestguard
GO


-- AQ40 Shared
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
GO
-- AQ40 Trash
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21889, 'Gloves of the Redeemed Prophecy', 75, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21890, 'Gloves of the Fallen Prophet', 75, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21891, 'Shard of the Fallen Star', 75, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21838, 'Garb of Royal Ascension', 71, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21837, 'Anubisath Warhammer', 71, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21836, 'Ritssyn''s Ring of Chaos', 71, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21856, 'Neretzek, The Blood Drinker', 71, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (21888, 'Gloves of the Immortal', 71, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj')), 21889, 0.10)--Gloves of the Redeemed Prophecy
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj')), 21890, 0.10)--Gloves of the Fallen Prophet
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj')), 21891, 0.10)--Shard of the Fallen Star
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj')), 21838, 0.10)--Garb of Royal Ascension
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj')), 21837, 0.10)--Anubisath Warhammer
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj')), 21836, 0.10)--Ritssyn's Ring of Chaos
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj')), 21856, 0.10)--Neretzek, The Blood Drinker
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj')), 21888, 0.10)--Gloves of the Immortal
INSERT INTO ItemClass (ItemID, ClassID) VALUES (21889, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Gloves of the Redeemed Prophecy
INSERT INTO ItemClass (ItemID, ClassID) VALUES (21890, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Gloves of the Fallen Prophet
GO
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
GO
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
GO
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
GO
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
GO
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
GO
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
GO
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
GO
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
GO
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
GO


-- Naxx T3
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22372, 'Desecrated Sandals', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22358, 'Desecrated Sabatons', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22365, 'Desecrated Boots', 60, NULL, 1, NULL)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22372, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Desecrated Sandals
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22372, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Desecrated Sandals
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22372, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Desecrated Sandals
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22358, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Desecrated Sabatons
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22358, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Desecrated Sabatons
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22365, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Desecrated Boots
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22365, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Desecrated Boots
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22365, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Desecrated Boots
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22365, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Desecrated Boots
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22352, 'Desecrated Legplates', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22359, 'Desecrated Legguards', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22366, 'Desecrated Leggings', 60, NULL, 1, NULL)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22352, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Desecrated Legplates
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22352, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Desecrated Legplates
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22359, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Desecrated Legguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22359, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Desecrated Legguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22359, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Desecrated Legguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22359, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Desecrated Legguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22366, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Desecrated Leggings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22366, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Desecrated Leggings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22366, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Desecrated Leggings
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22363, 'Desecrated Girdle', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22370, 'Desecrated Belt', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22356, 'Desecrated Waistguard', 60, NULL, 1, NULL)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22363, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Desecrated Girdle
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22363, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Desecrated Girdle
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22363, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Desecrated Girdle
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22363, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Desecrated Girdle
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22370, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Desecrated Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22370, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Desecrated Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22370, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Desecrated Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22356, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Desecrated Waistguard
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22356, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Desecrated Waistguard
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22364, 'Desecrated Handguards', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22371, 'Desecrated Gloves', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22357, 'Desecrated Gauntlets', 60, NULL, 1, NULL)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22364, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Desecrated Handguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22364, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Desecrated Handguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22364, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Desecrated Handguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22364, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Desecrated Handguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22371, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Desecrated Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22371, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Desecrated Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22371, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Desecrated Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22357, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Desecrated Gauntlets
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22357, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Desecrated Gauntlets
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22355, 'Desecrated Bracers', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22369, 'Desecrated Bindings', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22362, 'Desecrated Wristguards', 60, NULL, 1, NULL)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22355, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Desecrated Bracers
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22355, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Desecrated Bracers
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22369, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Desecrated Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22369, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Desecrated Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22369, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Desecrated Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22362, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Desecrated Wristguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22362, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Desecrated Wristguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22362, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Desecrated Wristguards
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22362, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Desecrated Wristguards
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22349, 'Desecrated Breastplate', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22350, 'Desecrated Tunic', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22351, 'Desecrated Robe', 60, NULL, 1, NULL)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22349, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Desecrated Breastplate
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22349, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Desecrated Breastplate
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22350, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Desecrated Tunic
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22350, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Desecrated Tunic
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22350, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Desecrated Tunic
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22350, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Desecrated Tunic
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22351, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Desecrated Robe
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22351, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Desecrated Robe
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22351, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Desecrated Robe
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22368, 'Desecrated Shoulderpads', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22354, 'Desecrated Pauldrons', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22361, 'Desecrated Spaulders', 60, NULL, 1, NULL)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22368, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Desecrated Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22368, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Desecrated Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22368, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Desecrated Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22354, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Desecrated Pauldrons
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22354, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Desecrated Pauldrons
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22361, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Desecrated Spaulders
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22361, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Desecrated Spaulders
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22361, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Desecrated Spaulders
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22361, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Desecrated Spaulders
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22353, 'Desecrated Helmet', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22360, 'Desecrated Headpiece', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22367, 'Desecrated Circlet', 60, NULL, 1, NULL)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22353, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Desecrated Helmet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22353, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Desecrated Helmet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22360, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Desecrated Headpiece
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22360, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Desecrated Headpiece
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22360, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Desecrated Headpiece
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22360, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Desecrated Headpiece
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22367, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Desecrated Circlet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22367, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Desecrated Circlet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22367, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Desecrated Circlet
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22498, 'Frostfire Circlet', 88, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, 22367)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22499, 'Frostfire Shoulderpads', 86, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, 22368)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22496, 'Frostfire Robe', 92, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, 22351)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22503, 'Frostfire Bindings', 88, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, 22369)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22501, 'Frostfire Gloves', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, 22371)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22502, 'Frostfire Belt', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, 22370)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22497, 'Frostfire Leggings', 88, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, 22366)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22500, 'Frostfire Sandals', 86, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, 22372)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22498, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Frostfire Circlet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22499, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Frostfire Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22496, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Frostfire Robe
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22503, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Frostfire Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22501, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Frostfire Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22502, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Frostfire Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22497, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Frostfire Leggings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22500, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Frostfire Sandals
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22514, 'Circlet of Faith', 88, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, 22367)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22515, 'Shoulderpads of Faith', 86, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, 22368)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22512, 'Robe of Faith', 92, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, 22351)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22519, 'Bindings of Faith', 88, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, 22369)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22517, 'Gloves of Faith', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, 22371)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22518, 'Belt of Faith', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, 22370)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22513, 'Leggings of Faith', 88, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, 22366)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22516, 'Sandals of Faith', 86, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, 22372)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22514, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Circlet of Faith
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22515, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Shoulderpads of Faith
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22512, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Robe of Faith
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22519, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Bindings of Faith
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22517, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Gloves of Faith
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22518, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Belt of Faith
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22513, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Leggings of Faith
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22516, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Sandals of Faith
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22506, 'Plagueheart Circlet', 88, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, 22367)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22507, 'Plagueheart Shoulderpads', 86, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, 22368)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22504, 'Plagueheart Robe', 92, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, 22351)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22511, 'Plagueheart Bindings', 88, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, 22369)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22509, 'Plagueheart Gloves', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, 22371)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22510, 'Plagueheart Belt', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, 22370)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22505, 'Plagueheart Leggings', 88, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, 22366)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22508, 'Plagueheart Sandals', 86, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, 22372)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22506, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Plagueheart Circlet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22507, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Plagueheart Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22504, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Plagueheart Robe
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22511, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Plagueheart Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22509, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Plagueheart Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22510, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Plagueheart Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22505, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Plagueheart Leggings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22508, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Plagueheart Sandals
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22490, 'Dreamwalker Headpiece', 88, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, 22360)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22491, 'Dreamwalker Spaulders', 86, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, 22361)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22488, 'Dreamwalker Tunic', 92, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, 22350)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22495, 'Dreamwalker Wristguards', 88, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, 22362)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22493, 'Dreamwalker Handguards', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, 22364)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22494, 'Dreamwalker Girdle', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, 22363)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22489, 'Dreamwalker Legguards', 88, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, 22359)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22492, 'Dreamwalker Boots', 86, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, 22365)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22490, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Dreamwalker Circlet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22491, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Dreamwalker Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22488, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Dreamwalker Robe
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22495, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Dreamwalker Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22493, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Dreamwalker Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22494, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Dreamwalker Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22489, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Dreamwalker Leggings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22492, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Dreamwalker Sandals
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22438, 'Cryptstalker Headpiece', 88, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, 22360)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22439, 'Cryptstalker Spaulders', 86, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, 22361)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22436, 'Cryptstalker Tunic', 92, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, 22350)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22443, 'Cryptstalker Wristguards', 88, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, 22362)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22441, 'Cryptstalker Handguards', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, 22364)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22442, 'Cryptstalker Girdle', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, 22363)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22437, 'Cryptstalker Legguards', 88, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, 22359)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22440, 'Cryptstalker Boots', 86, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, 22365)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22438, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Cryptstalker Circlet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22439, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Cryptstalker Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22436, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Cryptstalker Robe
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22443, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Cryptstalker Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22441, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Cryptstalker Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22442, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Cryptstalker Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22437, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Cryptstalker Leggings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22440, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Cryptstalker Sandals
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22428, 'Redemption Headpiece', 88, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, 22360)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22429, 'Redemption Spaulders', 86, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, 22361)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22425, 'Redemption Tunic', 92, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, 22350)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22424, 'Redemption Wristguards', 88, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, 22362)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22426, 'Redemption Handguards', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, 22364)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22431, 'Redemption Girdle', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, 22363)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22427, 'Redemption Legguards', 88, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, 22359)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22430, 'Redemption Boots', 86, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, 22365)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22428, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Redemption Circlet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22429, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Redemption Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22425, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Redemption Robe
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22424, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Redemption Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22426, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Redemption Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22431, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Redemption Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22427, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Redemption Leggings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22430, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Redemption Sandals
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22466, 'Earthshatter Headpiece', 88, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, 22360)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22467, 'Earthshatter Spaulders', 86, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, 22361)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22464, 'Earthshatter Tunic', 92, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, 22350)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22471, 'Earthshatter Wristguards', 88, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, 22362)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22469, 'Earthshatter Handguards', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, 22364)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22470, 'Earthshatter Girdle', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, 22363)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22465, 'Earthshatter Legguards', 88, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, 22359)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22468, 'Earthshatter Boots', 86, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, 22365)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22466, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Earthshatter Circlet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22467, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Earthshatter Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22464, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Earthshatter Robe
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22471, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Earthshatter Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22469, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Earthshatter Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22470, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Earthshatter Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22465, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Earthshatter Leggings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22468, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Earthshatter Sandals
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22478, 'Bonescythe Helmet', 88, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, 22353)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22479, 'Bonescythe Pauldrons', 86, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, 22354)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22476, 'Bonescythe Breastplate', 92, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, 22349)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22483, 'Bonescythe Bracers', 88, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, 22355)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22481, 'Bonescythe Gauntlets', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, 22357)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22482, 'Bonescythe Waistguard', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, 22356)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22477, 'Bonescythe Legplates', 88, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, 22352)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22480, 'Bonescythe Sabatons', 86, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, 22358)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22478, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bonescythe Circlet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22479, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bonescythe Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22476, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bonescythe Robe
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22483, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bonescythe Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22481, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bonescythe Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22482, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bonescythe Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22477, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bonescythe Leggings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22480, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bonescythe Sandals
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22418, 'Dreadnaught Helmet', 88, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, 22353)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22419, 'Dreadnaught Pauldrons', 86, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, 22354)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22416, 'Dreadnaught Breastplate', 92, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, 22349)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22423, 'Dreadnaught Bracers', 88, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, 22355)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22421, 'Dreadnaught Gauntlets', 88, (SELECT ID FROM Slot WHERE Name = 'Hands'), 0, 22357)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22422, 'Dreadnaught Waistguard', 88, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, 22356)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22417, 'Dreadnaught Legplates', 88, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, 22352)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22420, 'Dreadnaught Sabatons', 86, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, 22358)
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22418, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Dreadnaught Circlet
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22419, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Dreadnaught Shoulderpads
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22416, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Dreadnaught Robe
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22423, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Dreadnaught Bindings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22421, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Dreadnaught Gloves
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22422, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Dreadnaught Belt
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22417, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Dreadnaught Leggings
INSERT INTO ItemClass (ItemID, ClassID) VALUES (22420, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Dreadnaught Sandals
GO
-- Naxx Trash
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23664, 'Pauldrons of Elemental Fury', 85, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23666, 'Belt of the Grand Crusader', 85, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23044, 'Harbinger of Doom', 83, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23069, 'Necro-Knight''s Garb', 85, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23221, 'Misplaced Servo Arm', 83, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23226, 'Ghoul Skin Tunic', 83, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23237, 'Ring of the Eternal Flame', 83, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23238, 'Stygian Buckler', 83, (SELECT ID FROM Slot WHERE Name = 'Shield'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23663, 'Girdle of Elemental Fury', 85, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23665, 'Leggings of Elemental Fury', 85, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23667, 'Spaulders of the Grand Crusader', 85, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23668, 'Leggings of the Grand Crusader', 85, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23664, 0.10)--Pauldrons of Elemental Fury
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23666, 0.10)--Belt of the Grand Crusader
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23044, 0.10)--Harbinger of Doom
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23069, 0.10)--Necro-Knight's Garb
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23221, 0.10)--Misplaced Servo Arm
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23226, 0.10)--Ghoul Skin Tunic
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23237, 0.10)--Ring of the Eternal Flame
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23238, 0.10)--Stygian Buckler
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23663, 0.10)--Girdle of Elemental Fury
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23665, 0.10)--Leggings of Elemental Fury
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23667, 0.10)--Spaulders of the Grand Crusader
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Trash' AND RaidID = (SELECT ID FROM Raid WHERE Name = 'Naxxramas')), 23668, 0.10)--Leggings of the Grand Crusader
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23664, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Pauldrons of Elemental Fury
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23666, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Belt of the Grand Crusader
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23069, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Necro-Knight's Garb
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23069, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Necro-Knight's Garb
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23069, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Necro-Knight's Garb
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23665, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Leggings of Elemental Fury
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23667, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Spaulders of the Grand Crusader
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23668, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Leggings of the Grand Crusader
GO
-- Anub'Rekhan
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22939, 'Band of Unanswered Prayers', 83, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22935, 'Touch of Frost', 83, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22937, 'Gem of Nerubis', 83, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22938, 'Cryptfiend Silk Cloak', 83, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22936, 'Wristguards of Vengeance', 83, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Anub''Rekhan'), 22355, 0.34)--Desecrated Bracers
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Anub''Rekhan'), 22369, 0.27)--Desecrated Bindings
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Anub''Rekhan'), 22362, 0.26)--Desecrated Wristguards
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Anub''Rekhan'), 22939, 0.24)--Band of Unanswered Prayers
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Anub''Rekhan'), 22935, 0.19)--Touch of Frost
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Anub''Rekhan'), 22937, 0.18)--Gem of Nerubis
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Anub''Rekhan'), 22938, 0.16)--Cryptfiend Silk Cloak
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Anub''Rekhan'), 22936, 0.15)--Wristguards of Vengeance
GO
-- Grand Widow Faerlina
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22942, 'The Widow''s Embrace', 81, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22941, 'Polar Shoulder Pads', 83, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22806, 'Widow''s Remorse', 81, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22940, 'Icebane Pauldrons', 83, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22943, 'Malice Stone Pendant', 83, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grand Widow Faerlina'), 22369, 0.37)--Desecrated Bindings
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grand Widow Faerlina'), 22355, 0.27)--Desecrated Bracers
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grand Widow Faerlina'), 22362, 0.27)--Desecrated Wristguards
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grand Widow Faerlina'), 22942, 0.20)--The Widow's Embrace
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grand Widow Faerlina'), 22941, 0.19)--Polar Shoulder Pads
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grand Widow Faerlina'), 22806, 0.18)--Widow's Remorse
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grand Widow Faerlina'), 22940, 0.17)--Icebane Pauldrons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grand Widow Faerlina'), 22943, 0.17)--Malice Stone Pendant
GO
-- Maexxna
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22954, 'Kiss of the Spider', 85, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22807, 'Wraith Blade', 83, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22947, 'Pendant of Forgotten Names', 85, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22804, 'Maexxna''s Fang', 83, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23220, 'Crystal Webbed Robe', 85, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Maexxna'), 22364, 0.53)--Desecrated Handguards
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Maexxna'), 22371, 0.53)--Desecrated Gloves
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Maexxna'), 22357, 0.38)--Desecrated Gauntlets
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Maexxna'), 22954, 0.22)--Kiss of the Spider
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Maexxna'), 22807, 0.17)--Wraith Blade
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Maexxna'), 22947, 0.15)--Pendant of Forgotten Names
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Maexxna'), 22804, 0.14)--Maexxna's Fang
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Maexxna'), 23220, 0.12)--Crystal Webbed Robe
GO
-- Noth the Plaguebringer
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23030, 'Cloak of the Scourge', 83, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23029, 'Noth''s Frigid Heart', 83, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23031, 'Band of the Inevitable', 83, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22816, 'Hatchet of Sundered Bone', 83, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23028, 'Hailstone Band', 83, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23006, 'Libram of Light', 83, (SELECT ID FROM Slot WHERE Name = 'Relic'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23005, 'Totem of Flowing Water', 83, (SELECT ID FROM Slot WHERE Name = 'Relic'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Noth the Plaguebringer'), 22363, 0.41)--Desecrated Girdle
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Noth the Plaguebringer'), 22370, 0.24)--Desecrated Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Noth the Plaguebringer'), 22356, 0.21)--Desecrated Waistguard
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Noth the Plaguebringer'), 23030, 0.19)--Cloak of the Scourge
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Noth the Plaguebringer'), 23029, 0.17)--Noth's Frigid Heart
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Noth the Plaguebringer'), 23031, 0.16)--Band of the Inevitable
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Noth the Plaguebringer'), 22816, 0.11)--Hatchet of Sundered Bone
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Noth the Plaguebringer'), 23028, 0.11)--Hailstone Band
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Noth the Plaguebringer'), 23006, 0.09)--Libram of Light
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Noth the Plaguebringer'), 23005, 0.05)--Totem of Flowing Water
GO
-- Heigan the Unclean
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23068, 'Legplates of Carnage', 83, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23033, 'Icy Scale Coif', 83, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23035, 'Preceptor''s Hat', 83, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23019, 'Icebane Helmet', 83, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23036, 'Necklace of Necropsy', 83, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Heigan the Unclean'), 22363, 0.39)--Desecrated Girdle
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Heigan the Unclean'), 22370, 0.37)--Desecrated Belt
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Heigan the Unclean'), 23068, 0.26)--Legplates of Carnage
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Heigan the Unclean'), 23033, 0.20)--Icy Scale Coif
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Heigan the Unclean'), 22356, 0.19)--Desecrated Waistguard
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Heigan the Unclean'), 23035, 0.16)--Preceptor's Hat
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Heigan the Unclean'), 23019, 0.11)--Icebane Helmet
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Heigan the Unclean'), 23036, 0.09)--Necklace of Necropsy
GO
-- Loatheb
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23038, 'Band of Unnatural Forces', 85, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23039, 'The Eye of Nerub', 83, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23037, 'Ring of Spiritual Fervor', 85, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22800, 'Brimstone Staff', 83, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23042, 'Loatheb''s Reflection', 85, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Loatheb'), 22352, 0.33)--Desecrated Legplates
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Loatheb'), 22359, 0.33)--Desecrated Legguards
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Loatheb'), 22366, 0.33)--Desecrated Leggings
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Loatheb'), 23038, 0.12)--Band of Unnatural Forces
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Loatheb'), 23039, 0.12)--The Eye of Nerub
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Loatheb'), 23037, 0.11)--Ring of Spiritual Fervor
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Loatheb'), 22800, 0.10)--Brimstone Staff
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Loatheb'), 23042, 0.09)--Loatheb's Reflection
GO
-- Instructor Razuvious
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23009, 'Wand of the Whispering Dead', 83, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23018, 'Signet of the Fallen Defender', 83, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23004, 'Idol of Longevity', 83, (SELECT ID FROM Slot WHERE Name = 'Relic'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23219, 'Girdle of the Mentor', 85, (SELECT ID FROM Slot WHERE Name = 'Waist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23017, 'Veil of Eclipse', 83, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23014, 'Iblis, Blade of the Fallen Seraph', 81, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Instructor Razuvious'), 22372, 0.32)--Desecrated Sandals
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Instructor Razuvious'), 22358, 0.28)--Desecrated Sabatons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Instructor Razuvious'), 22365, 0.28)--Desecrated Boots
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Instructor Razuvious'), 23009, 0.18)--Wand of the Whispering Dead
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Instructor Razuvious'), 23018, 0.17)--Signet of the Fallen Defender
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Instructor Razuvious'), 23004, 0.15)--Idol of Longevity
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Instructor Razuvious'), 23219, 0.12)--Girdle of the Mentor
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Instructor Razuvious'), 23017, 0.11)--Veil of Eclipse
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Instructor Razuvious'), 23014, 0.10)--Iblis, Blade of the Fallen Seraph
GO
-- Gothik the Harvester
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23021, 'The Soul Harvester''s Bindings', 83, (SELECT ID FROM Slot WHERE Name = 'Wrist'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23032, 'Glacial Headdress', 83, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23023, 'Sadist''s Collar', 83, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23020, 'Polar Helmet', 83, (SELECT ID FROM Slot WHERE Name = 'Head'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23073, 'Boots of Displacement', 83, (SELECT ID FROM Slot WHERE Name = 'Feet'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gothik the Harvester'), 22372, 0.40)--Desecrated Sandals
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gothik the Harvester'), 22365, 0.26)--Desecrated Boots
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gothik the Harvester'), 23021, 0.26)--The Soul Harvester's Bindings
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gothik the Harvester'), 23032, 0.26)--Glacial Headdress
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gothik the Harvester'), 22358, 0.23)--Desecrated Sabatons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gothik the Harvester'), 23023, 0.11)--Sadist's Collar
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gothik the Harvester'), 23020, 0.09)--Polar Helmet
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gothik the Harvester'), 23073, 0.09)--Boots of Displacement
GO
-- Four Horsemen
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22691, 'Corrupted Ashbringer', 86, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22809, 'Maul of the Redeemed Crusader', 83, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22811, 'Soulstring', 83, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23025, 'Seal of the Damned', 85, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23027, 'Warmth of Forgiveness', 85, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23071, 'Leggings of Apocalypse', 83, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Four Horsemen'), 22349, 0.63)--Desecrated Breastplate
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Four Horsemen'), 22350, 0.48)--Desecrated Tunic
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Four Horsemen'), 22351, 0.46)--Desecrated Robe
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Four Horsemen'), 22691, 0.27)--Corrupted Ashbringer
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Four Horsemen'), 22809, 0.16)--Maul of the Redeemed Crusader
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Four Horsemen'), 22811, 0.15)--Soulstring
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Four Horsemen'), 23025, 0.10)--Seal of the Damned
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Four Horsemen'), 23027, 0.10)--Warmth of Forgiveness
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'The Four Horsemen'), 23071, 0.10)--Leggings of Apocalypse
GO
-- Patchwerk
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22960, 'Cloak of Suturing', 83, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22961, 'Band of Reanimation', 83, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22815, 'Severance', 81, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22820, 'Wand of Fates', 83, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22818, 'The Plague Bearer', 83, (SELECT ID FROM Slot WHERE Name = 'Shield'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Patchwerk'), 22368, 0.34)--Desecrated Shoulderpads
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Patchwerk'), 22354, 0.30)--Desecrated Pauldrons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Patchwerk'), 22361, 0.28)--Desecrated Spaulders
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Patchwerk'), 22960, 0.21)--Cloak of Suturing
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Patchwerk'), 22961, 0.18)--Band of Reanimation
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Patchwerk'), 22815, 0.17)--Severance
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Patchwerk'), 22820, 0.17)--Wand of Fates
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Patchwerk'), 22818, 0.12)--The Plague Bearer
GO
-- Grobbulus
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22967, 'Icy Scale Spaulders', 83, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22810, 'Toxin Injector', 81, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22988, 'The End of Dreams', 83, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22803, 'Midnight Haze', 81, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22968, 'Glacial Mantle', 83, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grobbulus'), 22354, 0.28)--Desecrated Pauldrons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grobbulus'), 22361, 0.28)--Desecrated Spaulders
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grobbulus'), 22368, 0.26)--Desecrated Shoulderpads
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grobbulus'), 22967, 0.22)--Icy Scale Spaulders
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grobbulus'), 22810, 0.20)--Toxin Injector
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grobbulus'), 22988, 0.19)--The End of Dreams
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grobbulus'), 22803, 0.18)--Midnight Haze
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Grobbulus'), 22968, 0.14)--Glacial Mantle
GO
-- Gluth
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22813, 'Claymore of Unholy Might', 81, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22981, 'Gluth''s Missing Collar', 83, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22994, 'Digested Hand of Power', 83, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23075, 'Death''s Bargain', 83, (SELECT ID FROM Slot WHERE Name = 'Shield'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22983, 'Rime Covered Mantle', 83, (SELECT ID FROM Slot WHERE Name = 'Shoulder'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22813, 0.23)--Claymore of Unholy Might
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22981, 0.23)--Gluth's Missing Collar
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22994, 0.16)--Digested Hand of Power
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 23075, 0.15)--Death's Bargain
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22354, 0.15)--Desecrated Pauldrons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22358, 0.14)--Desecrated Sabatons
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22983, 0.13)--Rime Covered Mantle
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22363, 0.11)--Desecrated Girdle
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22369, 0.10)--Desecrated Bindings
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22355, 0.09)--Desecrated Bracers
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22361, 0.09)--Desecrated Spaulders
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22372, 0.07)--Desecrated Sandals
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22368, 0.06)--Desecrated Shoulderpads
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22365, 0.05)--Desecrated Boots
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22356, 0.03)--Desecrated Waistguard
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22362, 0.03)--Desecrated Wristguards
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Gluth'), 22370, 0.03)--Desecrated Belt
GO
-- Thaddius
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23070, 'Leggings of Polarity', 85, (SELECT ID FROM Slot WHERE Name = 'Legs'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22801, 'Spire of Twilight', 83, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23001, 'Eye of Diminution', 85, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22808, 'The Castigator', 83, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23000, 'Plated Abomination Ribcage', 85, (SELECT ID FROM Slot WHERE Name = 'Chest'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Thaddius'), 22353, 0.63)--Desecrated Helmet
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Thaddius'), 22360, 0.48)--Desecrated Headpiece
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Thaddius'), 22367, 0.46)--Desecrated Circlet
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Thaddius'), 23070, 0.27)--Leggings of Polarity
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Thaddius'), 22801, 0.16)--Spire of Twilight
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Thaddius'), 23001, 0.15)--Eye of Diminution
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Thaddius'), 22808, 0.10)--The Castigator
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Thaddius'), 23000, 0.10)--Plated Abomination Ribcage
GO
-- Sapphiron
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23047, 'Eye of the Dead', 90, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23045, 'Shroud of Dominion', 90, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23242, 'Claw of the Frost Wyrm', 88, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23043, 'The Face of Death', 90, (SELECT ID FROM Slot WHERE Name = 'Shield'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23041, 'Slayer''s Crest', 90, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23048, 'Sapphiron''s Right Eye', 90, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23040, 'Glyph of Deflection', 90, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23046, 'The Restrained Essence of Sapphiron', 90, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23049, 'Sapphiron''s Left Eye', 90, (SELECT ID FROM Slot WHERE Name = 'Off Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23050, 'Cloak of the Necropolis', 90, (SELECT ID FROM Slot WHERE Name = 'Back'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sapphiron'), 23047, 0.39)--Eye of the Dead
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sapphiron'), 23045, 0.29)--Shroud of Dominion
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sapphiron'), 23242, 0.21)--Claw of the Frost Wyrm
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sapphiron'), 23043, 0.18)--The Face of Death
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sapphiron'), 23041, 0.14)--Slayer's Crest
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sapphiron'), 23048, 0.14)--Sapphiron's Right Eye
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sapphiron'), 23040, 0.11)--Glyph of Deflection
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sapphiron'), 23046, 0.11)--The Restrained Essence of Sapphiron
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sapphiron'), 23049, 0.07)--Sapphiron's Left Eye
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Sapphiron'), 23050, 0.07)--Cloak of the Necropolis
GO
-- Kel'Thuzad
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22520, 'The Phylactery of Kel''Thuzad', 60, NULL, 1, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23206, 'Mark of the Champion', 90, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, 22520)--AP
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23207, 'Mark of the Champion', 90, (SELECT ID FROM Slot WHERE Name = 'Trinket'), 0, 22520)--SP
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23065, 'Ring of the Earthshatterer', 92, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23066, 'Ring of Redemption', 92, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22798, 'Might of Menethil', 89, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23057, 'Gem of Trapped Innocents', 92, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23060, 'Bonescythe Ring', 92, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23059, 'Ring of the Dreadnaught', 92, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22802, 'Kingsfall', 89, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23053, 'Stormrage''s Talisman of Seething', 92, (SELECT ID FROM Slot WHERE Name = 'Neck'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22799, 'Soulseeker', 89, (SELECT ID FROM Slot WHERE Name = 'Two-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23056, 'Hammer of the Twisting Nether', 89, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23062, 'Frostfire Ring', 92, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23067, 'Ring of the Cryptstalker', 92, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22821, 'Doomfinger', 92, (SELECT ID FROM Slot WHERE Name = 'Ranged'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23061, 'Ring of Faith', 92, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23054, 'Gressil, Dawn of Ruin', 89, (SELECT ID FROM Slot WHERE Name = 'One-Hand'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23063, 'Plagueheart Ring', 92, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (22819, 'Shield of Condemnation', 92, (SELECT ID FROM Slot WHERE Name = 'Shield'), 0, NULL)
INSERT INTO Item (ID, Name, Level, SlotID, IsQuestItem, RewardFromQuestItem) VALUES (23064, 'Ring of the Dreamwalker', 92, (SELECT ID FROM Slot WHERE Name = 'Finger'), 0, NULL)
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 22520, 1.00)--The Phylactery of Kel'Thuzad
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23065, 0.25)--Ring of the Earthshatterer
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23066, 0.25)--Ring of Redemption
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 22798, 0.35)--Might of Menethil
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23057, 0.35)--Gem of Trapped Innocents
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23060, 0.25)--Bonescythe Ring
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23059, 0.25)--Ring of the Dreadnaught
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 22802, 0.22)--Kingsfall
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23053, 0.22)--Stormrage's Talisman of Seething
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 22799, 0.17)--Soulseeker
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23056, 0.17)--Hammer of the Twisting Nether
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23062, 0.25)--Frostfire Ring
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23067, 0.25)--Ring of the Cryptstalker
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 22821, 0.13)--Doomfinger
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23061, 0.25)--Ring of Faith
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23054, 0.09)--Gressil, Dawn of Ruin
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23063, 0.25)--Plagueheart Ring
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 22819, 0.04)--Shield of Condemnation
INSERT INTO BossLoot (BossID, ItemID, DropChance) VALUES ((SELECT ID FROM Boss WHERE Name = 'Kel''Thuzad'), 23064, 0.25)--Ring of the Dreamwalker
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23065, (SELECT ID FROM Class WHERE [Name] = 'Shaman'))--Ring of the Earthshatterer
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23066, (SELECT ID FROM Class WHERE [Name] = 'Paladin'))--Ring of Redemption
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23060, (SELECT ID FROM Class WHERE [Name] = 'Rogue'))--Bonescythe Ring
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23059, (SELECT ID FROM Class WHERE [Name] = 'Warrior'))--Ring of the Dreadnaught
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23062, (SELECT ID FROM Class WHERE [Name] = 'Mage'))--Frostfire Ring
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23067, (SELECT ID FROM Class WHERE [Name] = 'Hunter'))--Ring of the Cryptstalker
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23061, (SELECT ID FROM Class WHERE [Name] = 'Priest'))--Ring of Faith
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23063, (SELECT ID FROM Class WHERE [Name] = 'Warlock'))--Plagueheart Ring
INSERT INTO ItemClass (ItemID, ClassID) VALUES (23064, (SELECT ID FROM Class WHERE [Name] = 'Druid'))--Ring of the Dreamwalker
GO
