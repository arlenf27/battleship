%% Arlen Feng
% Battleship 1
% Sprite Sheet Used: Battleship.png (Provided from SDP Resources Page on ENGR 
% 1181.01 Carmen Website)
clc
clear

%% Main Program

% Generating Board
scene = simpleGameEngine('Battleship.png',84,84,15,[200,200,200]);

playAgain = 'y';

while(playAgain == 'y')
Board1 = [2,2,2,2,2,2,2,2,2,2,15,2,2,2,2,2,2,2,2,2,2;2,2,2,2,2,2,2,2,2,2,15,2,2,2,2,2,2,2,2,2,2;2,2,2,2,2,2,2,2,2,2,15,2,2,2,2,2,2,2,2,2,2;2,2,2,2,2,2,2,2,2,2,15,2,2,2,2,2,2,2,2,2,2;2,2,2,2,2,2,2,2,2,2,15,2,2,2,2,2,2,2,2,2,2;2,2,2,2,2,2,2,2,2,2,15,2,2,2,2,2,2,2,2,2,2;2,2,2,2,2,2,2,2,2,2,15,2,2,2,2,2,2,2,2,2,2;2,2,2,2,2,2,2,2,2,2,15,2,2,2,2,2,2,2,2,2,2;2,2,2,2,2,2,2,2,2,2,15,2,2,2,2,2,2,2,2,2,2;2,2,2,2,2,2,2,2,2,2,15,2,2,2,2,2,2,2,2,2,2];

% Note: Though the locations of the ships are random, there are exactly
% three ships (each of size 3 by 1) for both the player and the computer

% Generating Random Player Ships and checking that they do not overlap with
% each other
[Board1, ranX,ranY,ranX2,ranY2,ranX3,ranY3] = generateRandomShips(Board1);

% Generating Locations of Computer ships
[compX,compY,compX2,compY2,compX3,compY3] = generateComputerShips();

% Drawing Scene with Text
drawScene(scene, Board1);

terminateText = text(13200,1000,'Click Here To Terminate Program');
terminateText.Rotation = -90;
terminateText.FontSize = 30;
terminateText.Color = "red";

playerText = text(5000,13000,'Player''s Board');
playerText.FontSize = 18;

computerText = text(18000,13000,'Computer''s Board');
computerText.FontSize = 18;

% If points go to 0, then the player loses, same with computer
playerPoints = 9;
computerPoints = 9;

% Simulating turns
computerR = randi(10);
computerC = randi(10);
shipLives = 2;
while(playerPoints > 0 && computerPoints > 0)
    % Player input
    [r,c] = getMouseInput(scene);
    if(c == 11)

        break
    else
        Board1(r,c) = 10;
        if(r == compX && abs(compY-c) < 2) || (abs(compX2-r) < 2 && c == compY2) || (r == compX3 && abs(compY3-c) < 2)
            computerPoints = computerPoints - 1;
            Board1(r,c) = 9;
        end
        drawScene(scene, Board1);
    end

    % Computer randomized turns
    if(shipLives == 0)
        shipLives = 2;
    end
    while(Board1(computerR,computerC) == 9 || Board1(computerR,computerC) == 10)
        % If the previous move was a hit, then this move would attempt (in
        % most cases) to hit the same ship by moving one spot to the top,
        % bottom, left, or right
        
        if(Board1(computerR,computerC) == 9)
            if(computerR~=1 && (Board1(computerR-1,computerC)>=3&&Board1(computerR-1,computerC)<=8)&& shipLives > 0)
                computerR = computerR-1;
                shipLives = shipLives-1;
            elseif(computerR~=10 && (Board1(computerR+1,computerC)>=3&&Board1(computerR+1,computerC)<=8)&& shipLives > 0)
                computerR = computerR + 1;
                shipLives = shipLives-1;
            elseif(computerC~=1 && (Board1(computerR,computerC-1)>=3&&Board1(computerR,computerC-1)<=8)&& shipLives > 0)
                computerC = computerC-1;
                shipLives = shipLives-1;
            elseif(computerC~=10 && (Board1(computerR,computerC+1)>=3&&Board1(computerR,computerC+1)<=8)&& shipLives > 0)
                computerC = computerC+1;
                shipLives = shipLives-1;
            elseif(computerR>2 && (Board1(computerR-2,computerC)>=3&&Board1(computerR-2,computerC)<=8)&& shipLives > 0)
                computerR = computerR-2;
                shipLives = shipLives-1;
            elseif(computerR<9 && (Board1(computerR+2,computerC)>=3&&Board1(computerR+2,computerC)<=8)&& shipLives > 0)
                computerR = computerR+2;
                shipLives = shipLives-1;
            elseif(computerC>2 && (Board1(computerR,computerC-2)>=3&&Board1(computerR,computerC-2)<=8)&& shipLives > 0)
                computerC = computerC-2;
                shipLives = shipLives-1;
            elseif(computerC<9 && (Board1(computerR,computerC+2)>=3&&Board1(computerR,computerC+2)<=8)&& shipLives > 0)
                computerC = computerC+2;
                shipLives = shipLives-1;
            else
                computerR = randi(10);
                computerC = randi(10);
            end
            
        else
            computerR = randi(10);
            computerC = randi(10);
        end
    end
    Board1(computerR,computerC) = 10;
    if(computerR == ranX && abs(ranY-computerC) < 2) || (abs(ranX2-computerR) < 2 && computerC == ranY2) || (computerR == ranX3 && abs(ranY3-computerC) < 2)
        playerPoints = playerPoints - 1;
        Board1(computerR,computerC) = 9;
    end
    drawScene(scene, Board1);

end

% Displaying ending message provided that the game is NOT terminated before
% then
winText = text(0,0,'');
winText.Color = "white";
loseText = text(0,0,'');
loseText.Color = "white";
if(computerPoints == 0)
    winText = text(9500,4000,'You Win. ');
    winText.FontSize = 150;
    winText.Color = "red";
elseif (playerPoints == 0)
    loseText = text(9500,4000,'You Lose. ');
    loseText.FontSize = 150;
    loseText.Color = "black";
end

if(c ~= 11)
playAgainText = text(2000, 6000, 'Play Again? (Press y/n)');
playAgainText.FontSize = 100;
playAgainText.Color = "green";

playAgain = getKeyboardInput(scene);
delete(playAgainText);
delete(winText);
delete(loseText);
else
    playAgain = 'n';
end

end

%% Function to generate random user ship locations
function [Board1, ranX,ranY,ranX2,ranY2,ranX3,ranY3] = generateRandomShips(Board1)
    ranX = randi([2,9]);
    ranY = randi([2,9]);
    Board1(ranX,ranY-1) = 3;
    Board1(ranX,ranY) = 4;
    Board1(ranX,ranY+1) = 5;

    ranX2 = randi([2,9]);
    ranY2 = randi([2,9]);
    while (abs(ranX2-ranX) < 2 || abs(ranY2-ranY) < 2)
        ranX2 = randi([2,9]);
        ranY2 = randi([2,9]);
    end
    Board1(ranX2-1,ranY2) = 6;
    Board1(ranX2,ranY2) = 7;
    Board1(ranX2+1,ranY2) = 8;

    ranX3 = randi([2,9]);
    ranY3 = randi([2,9]);
    while ((abs(ranX2-ranX) < 2 || abs(ranY2-ranY) < 2) || (abs(ranX3-ranX) < 2 || abs(ranY3-ranY) < 2) || (abs(ranX3-ranX2) < 2 || abs(ranY3-ranY2) < 2))
        ranX3 = randi([2,9]);
        ranY3 = randi([2,9]);
    end
    Board1(ranX3,ranY3-1) = 3;
    Board1(ranX3,ranY3) = 4;
    Board1(ranX3,ranY3+1) = 5;
end

%% Function to generate random computer ship locations
function [compX,compY,compX2,compY2,compX3,compY3] = generateComputerShips()
    compX = randi([2,8]);
    compY = randi([13,20]);

    compX2 = randi([2,8]);
    compY2 = randi([13,20]);
    while (abs(compX2-compX) < 2 || abs(compY2-compY) < 2)
        compX2 = randi([2,8]);
        compY2 = randi([13,20]);
    end

    compX3 = randi([2,8]);
    compY3 = randi([13,20]);
    while ((abs(compX2-compX) < 2 || abs(compY2-compY) < 2) || (abs(compX3-compX) < 2 || abs(compY3-compY) < 2) || (abs(compX3-compX2) < 2 || abs(compY3-compY2) < 2))
        compX3 = randi([2,8]);
        compY3 = randi([13,20]);
    end
end