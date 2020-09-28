USE master
GO

DROP DATABASE IF EXISTS LootPriority
GO

CREATE DATABASE LootPriority
GO

USE LootPriority
GO

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
INSERT INTO Character (Name, PlayerID, ClassID, TeamID, RealmID) VALUES ( 'Zoey',  (SELECT ID FROM Player WHERE Nickname = 'Zoey'), (SELECT ID FROM Class WHERE Name = 'Mage'), (SELECT ID FROM Team WHERE Name = 'ENCORE Purple'), (SELECT ID FROM Realm WHERE Name = 'Grobbulus'))


SELECT *
FROM Player p
LEFT JOIN Character c
ON c.PlayerID = p.ID
LEFT JOIN Class cl
ON cl.ID = c.ClassID
LEFT JOIN Team t
ON t.ID = c.TeamID
LEFT JOIN Realm r
ON r.ID = c.RealmID
--WHERE p.Nickname = 'Zoey'



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
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL,
	FOREIGN KEY (RaidID) REFERENCES Raid (ID),
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

INSERT INTO RaidLog (Name, RaidID, StartDate, EndDate) VALUES ('Purple AQ 2020-09-23', (SELECT ID FROM Raid WHERE Name = 'Temple of Ahn''Qiraj'), '2020-09-23 18:00:00', '2020-09-23 20:00:00')
INSERT INTO RaidLog (Name, RaidID, StartDate, EndDate) VALUES ('Purple BWL 2020-09-27', (SELECT ID FROM Raid WHERE Name = 'Blackwing Lair'), '2020-09-27 18:00:00', '2020-09-27 19:00:00')
INSERT INTO RaidLog (Name, RaidID, StartDate, EndDate) VALUES ('Purple MC 2020-09-27', (SELECT ID FROM Raid WHERE Name = 'Molten Core'), '2020-09-27 19:00:00', '2020-09-27 20:00:00')

INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple AQ 2020-09-23'), (SELECT ID FROM Character WHERE Name = 'Zoey'))
INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple BWL 2020-09-27'), (SELECT ID FROM Character WHERE Name = 'Zoey'))
INSERT INTO RaidLogCharacter (RaidLogID, CharacterID) VALUES ((SELECT ID FROM RaidLog WHERE Name = 'Purple MC 2020-09-27'), (SELECT ID FROM Character WHERE Name = 'Zoey'))


SELECT *
FROM Raid r
LEFT JOIN RealmRaid rr
ON rr.RaidID = r.ID
LEFT JOIN Realm re
ON re.ID = rr.RealmID
LEFT JOIN Boss b
ON b.RaidID = r.ID

SELECT *
FROM Raid r
LEFT JOIN RaidLog rl
ON rl.RaidID = r.ID
LEFT JOIN RaidLogCharacter rlc
ON rlc.RaidLogID = rl.ID
LEFT JOIN Character c
ON c.ID = rlc.CharacterID
LEFT JOIN Class cl
ON cl.ID = c.ClassID