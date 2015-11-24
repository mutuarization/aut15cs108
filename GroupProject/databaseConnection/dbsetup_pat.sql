use c_cs108_mateog;

DROP TABLE IF EXISTS Choices;
DROP TABLE IF EXISTS Questions;

-- Represents all questions in the website
CREATE TABLE Questions (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	quizId BIGINT NOT NULL,
	FOREIGN KEY (quizId) REFERENCES quizzes(id),
	type VARCHAR(255) NOT NULL,
	score INT NOT NULL,
	question VARCHAR(255),
	correctAnswer VARCHAR(255),
	imageUrl VARCHAR(255)
);

-- Represents all questions in the website
CREATE TABLE Choices (
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	questionId INT NOT NULL,
	FOREIGN KEY (questionId) REFERENCES Questions(id),
	choice VARCHAR(255) NOT NULL,
	isCorrect BOOLEAN NOT NULL
);