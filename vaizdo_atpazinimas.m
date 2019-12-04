close all
clear all
clc
% scanning letter examples and character counting
pavadinimas = 'train_data.png';
pozymiai_tinklo_mokymui = pozymiai_raidems_atpazinti(pavadinimas, 9);
% Creating a Recognizer
% features are transferred from the array of cells to the matrix
P = cell2mat(pozymiai_tinklo_mokymui);
% creates a matrix of correct answers: 12 letters, 9 lines for teaching
T = [eye(12), eye(12), eye(12), eye(12), eye(12), eye(12), eye(12), eye(12), eye(12)];
% creating an SBF network for the given P and T relationships
tinklas = newrb(P,T,0,1,13);

% Network Verification
% calculating network output for unknown features
P2 = P(:,12:24);
Y2 = sim(tinklas, P2);
% it is searched for which output has the highest value
[a2, b2] = max(Y2);
% Result rendering
% let's calculate the number of letters - the number of columns in the P2 attribute
raidziu_sk = size(P2,2);
% we will store the result in the 'atsakymas = answer' variable
atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            atsakymas = [atsakymas, 'A'];
        case 2
            atsakymas = [atsakymas, 'B'];
        case 3
            atsakymas = [atsakymas, 'C'];
        case 4
            atsakymas = [atsakymas, 'K'];
        case 5
            atsakymas = [atsakymas, 'L'];
        case 6
            atsakymas = [atsakymas, 'G'];
        case 7
            atsakymas = [atsakymas, '#'];
        case 8
            atsakymas = [atsakymas, '*'];
        case 9
            atsakymas = [atsakymas, 'E'];
        case 10
            atsakymas = [atsakymas, 'N'];
        case 11
            atsakymas = [atsakymas, 'J'];
        case 12
            atsakymas = [atsakymas, 'O'];
    end
end
% display the result in the command window
% disp(atsakymas)
figure(7), text(0.1,0.5,atsakymas,'FontSize',38)
% exclusion of the signs "BLACK"
pavadinimas = 'test_black.png';
pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);

% Character Recognition
% features are transferred from the array of cells to the matrix
P2 = cell2mat(pozymiai_patikrai);
% calculating network output for unknown features
Y2 = sim(tinklas, P2);
% it is searched for which output has the highest value
[a2, b2] = max(Y2);
% Result rendering
% let's calculate the number of letters - the number of columns in the P2 attribute
raidziu_sk = size(P2,2);
% rezultat? saugosime kintamajame 'atsakymas'
atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            atsakymas = [atsakymas, 'A'];
        case 2
            atsakymas = [atsakymas, 'B'];
        case 3
            atsakymas = [atsakymas, 'C'];
        case 4
            atsakymas = [atsakymas, 'K'];
        case 5
            atsakymas = [atsakymas, 'L'];
        case 6
            atsakymas = [atsakymas, 'G'];
        case 7
            atsakymas = [atsakymas, '#'];
        case 8
            atsakymas = [atsakymas, '*'];
        case 9
            atsakymas = [atsakymas, 'E'];
        case 10
            atsakymas = [atsakymas, 'N'];
        case 11
            atsakymas = [atsakymas, 'J'];
        case 12
            atsakymas = [atsakymas, 'J'];
    end
end
% display the result in the command window
% disp(atsakymas)
figure(8), text(0.1,0.5,atsakymas,'FontSize',38), axis off
% distinguishing the word "JOB"
pavadinimas = 'test_job.png';
pozymiai_patikrai = pozymiai_raidems_atpazinti(pavadinimas, 1);

% Raid?i? atpa?inimas
% features are transferred from the array of cells to the matrix
P2 = cell2mat(pozymiai_patikrai);
% calculating network output for unknown features
Y2 = sim(tinklas, P2);
% it is searched for which output has the highest value
[a2, b2] = max(Y2);
% Result rendering
% let's calculate the number of letters - the number of columns in the P2 attribute
raidziu_sk = size(P2,2);
% we will store the result in a variable 'atsakymas'
atsakymas = [];
for k = 1:raidziu_sk
    switch b2(k)
        case 1
            atsakymas = [atsakymas, 'A'];
        case 2
            atsakymas = [atsakymas, 'B'];
        case 3
            atsakymas = [atsakymas, 'C'];
        case 4
            atsakymas = [atsakymas, 'K'];
        case 5
            atsakymas = [atsakymas, 'L'];
        case 6
            atsakymas = [atsakymas, 'G'];
        case 7
            atsakymas = [atsakymas, '#'];
        case 8
            atsakymas = [atsakymas, '*'];
        case 9
            atsakymas = [atsakymas, 'E'];
        case 10
            atsakymas = [atsakymas, 'N'];
        case 11
            atsakymas = [atsakymas, 'J'];
        case 12
            atsakymas = [atsakymas, 'O'];
    end
end
% display the result in the command window
disp(atsakymas)
figure(9), text(0.1,0.5,atsakymas,'FontSize',38), axis off
