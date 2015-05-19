%run IGT, copyright Patrick B. Williams. 2013.

inst01 = ['In this experiment, you will be asked to repeatedly select a card'...
    ' from one of the four decks above. You can select a card by clicking the'...
    ' mouse on one of the decks.\n\n'...
    'With each card, you can win some money, but you can also lose some.'...
    ' Some decks will be more profitable than others. Try to choose cards'...
    ' from most profitable decks so that your total winnings will be as high as possible.\n\n'...
    '  You will get 100 chances to select a card from the deck that you think will'...
    ' give you the highest winnings. Your total earnings and the number of cards'...
    ' selected will be displayed on screen.\n\nYou start with $2000.'];

A_win  = 100;
B_win  = 100;
C_win  = 50;
D_win  = 50;

A_lose = [1250 0 0 0 0 0 0 0 0 0];
B_lose = [150 350 250 300 200 0 0 0 0 0];
C_lose = [50 50 50 50 0 0 0 0 0 0];
D_lose = [250 0 0 0 0 0 0 0 0 0 0];

initBank = 2000;
currTot = initBank;
allCurrTot(1,:) = 2000;

for i = 1:10
    A_loseRand(1:10,i) = A_lose(randperm(10));
    B_loseRand(1:10,i) = B_lose(randperm(10));
    C_loseRand(1:10,i) = C_lose(randperm(10));
    D_loseRand(1:10,i) = D_lose(randperm(10));
end

A_loseRand = A_loseRand( : );
B_loseRand = B_loseRand( : );
C_loseRand = C_loseRand( : );
D_loseRand = D_loseRand( : );

A_counter = 0;
B_counter = 0;
C_counter = 0;
D_counter = 0;

hGrid = linspace(rect(1),rect(3),100);
vGrid = linspace(rect(2),rect(4),100);
rect_A =      [hGrid(13) vGrid(20) hGrid(27) vGrid(55)];
rect_B =      [hGrid(33) vGrid(20) hGrid(47) vGrid(55)];
rect_C =      [hGrid(53) vGrid(20) hGrid(67) vGrid(55)];
rect_D =      [hGrid(73) vGrid(20) hGrid(87) vGrid(55)];
rect_submit = [hGrid(40) vGrid(80) hGrid(60) vGrid(90)];

grow = 20;

rect_A2 =     [rect_A(1)-grow rect_A(2)-grow rect_A(3)+grow rect_A(4)+grow];
rect_B2 =     [rect_B(1)-grow rect_B(2)-grow rect_B(3)+grow rect_B(4)+grow];
rect_C2 =     [rect_C(1)-grow rect_C(2)-grow rect_C(3)+grow rect_C(4)+grow];
rect_D2 =     [rect_D(1)-grow rect_D(2)-grow rect_D(3)+grow rect_D(4)+grow];

imgLoc = [base_dir fs 'IGT'];
I = imread([imgLoc fs 'playing-card-back.jpg']);
tex=Screen('MakeTexture', wPtr, I);

% [x,y,buttons] = GetMouse(wPtr);
Screen(wPtr,'TextSize',20);
DrawFormattedText(wPtr,'Instructions','center',hGrid(6),black);

% draw static letter images below cards
Screen('DrawTexture', wPtr, tex,[],rect_A);
Screen('DrawText',wPtr,'A',(rect_A(1) + rect_A(3))/2,((rect_A(2) + rect_A(4))/2)+250,black);

Screen('DrawTexture', wPtr, tex,[],rect_B);
Screen('DrawText',wPtr,'B',(rect_B(1) + rect_B(3))/2,((rect_B(2) + rect_B(4))/2)+250,black);

Screen('DrawTexture', wPtr, tex,[],rect_C);
Screen('DrawText',wPtr,'C',(rect_C(1) + rect_C(3))/2,((rect_C(2) + rect_C(4))/2)+250,black);

Screen('DrawTexture', wPtr, tex,[],rect_D);
Screen('DrawText',wPtr,'D',(rect_D(1) + rect_D(3))/2,((rect_D(2) + rect_D(4))/2)+250,black);

Screen(wPtr,'TextSize',15);

DrawFormattedText(wPtr,inst01,rect_A(1),hGrid(55),black,110,[],[],1.5);
DrawFormattedText(wPtr,'Press any key to continue.','center',vGrid(93),black);

Screen('Flip',wPtr);
KbWait([], 2);

for i = 1:100
    allStart = GetSecs;
    card = 0;
    
    A_counter = A_counter + 1;
    B_counter = B_counter + 1;
    C_counter = C_counter + 1;
    D_counter = D_counter + 1;

    while 1
        [x,y,buttons] = GetMouse(wPtr);
        Screen(wPtr,'TextSize',20);
        DrawFormattedText(wPtr,['current total: ' num2str(currTot)],'center',hGrid(6),black);
%         DrawFormattedText(wPtr,num2str(i),'center',hGrid(8),black);        %displays round number (for testing
        % display winnings of previous round
        if i > 1
            DrawFormattedText(wPtr,['previous total: ' num2str(allCurrTot(i-1))],'center',hGrid(3),black);
            Screen(wPtr,'TextSize',30);
            if cards(i-1) == 'A'
                DrawFormattedText(wPtr,['win: ' num2str(win(i-1))],((rect_A(1) + rect_A(3))/2)-100,((rect_A(2) + rect_A(4))/2)-290,green);
                DrawFormattedText(wPtr,['lose: ' num2str(lose(i-1))],((rect_A(1) + rect_A(3))/2)-100,((rect_A(2) + rect_A(4))/2)-250,red);
            elseif cards(i-1) == 'B'
                DrawFormattedText(wPtr,['win: ' num2str(win(i-1))],((rect_B(1) + rect_B(3))/2)-100,((rect_B(2) + rect_B(4))/2)-290,green);
                DrawFormattedText(wPtr,['lose: ' num2str(lose(i-1))],((rect_B(1) + rect_B(3))/2)-100,((rect_B(2) + rect_B(4))/2)-250,red);
            elseif cards(i-1) == 'C'
                DrawFormattedText(wPtr,['win: ' num2str(win(i-1))],((rect_C(1) + rect_C(3))/2)-100,((rect_C(2) + rect_C(4))/2)-290,green);
                DrawFormattedText(wPtr,['lose: ' num2str(lose(i-1))],((rect_C(1) + rect_C(3))/2)-100,((rect_C(2) + rect_C(4))/2)-250,red);
            elseif cards(i-1) == 'D'
                DrawFormattedText(wPtr,['win: ' num2str(win(i-1))],((rect_D(1) + rect_D(3))/2)-100,((rect_D(2) + rect_D(4))/2)-290,green);
                DrawFormattedText(wPtr,['lose: ' num2str(lose(i-1))],((rect_D(1) + rect_D(3))/2)-100,((rect_D(2) + rect_D(4))/2)-250,red);
            end
        end
        
        % draw static letter images below cards
        Screen('DrawTexture', wPtr, tex,[],rect_A);
        Screen('DrawText',wPtr,'A',(rect_A(1) + rect_A(3))/2,((rect_A(2) + rect_A(4))/2)+250,black);

        Screen('DrawTexture', wPtr, tex,[],rect_B);
        Screen('DrawText',wPtr,'B',(rect_B(1) + rect_B(3))/2,((rect_B(2) + rect_B(4))/2)+250,black);

        Screen('DrawTexture', wPtr, tex,[],rect_C);
        Screen('DrawText',wPtr,'C',(rect_C(1) + rect_C(3))/2,((rect_C(2) + rect_C(4))/2)+250,black);

        Screen('DrawTexture', wPtr, tex,[],rect_D);
        Screen('DrawText',wPtr,'D',(rect_D(1) + rect_D(3))/2,((rect_D(2) + rect_D(4))/2)+250,black);

        Screen(wPtr,'TextSize',20);

        Screen('FrameRect', wPtr, black, [rect_submit],5);
        Screen('DrawText',wPtr,'Submit',(rect_submit(1) + rect_submit(3))/2-50,(rect_submit(2) + rect_submit(4))/2-20,black);

        %animation when scrolling over cards. If a card is clicked, "card" variable set [A,B,C,D]
        if x > rect_A(1) && x < rect_A(3) && y > rect_A(2) && y < rect_A(4)
            Screen('DrawTexture', wPtr, tex,[],rect_A2);
            Screen('DrawText',wPtr,'A',(rect_A(1) + rect_A(3))/2,(rect_A(2) + rect_A(4))/2,white);
            if buttons(1)
                card = 'A';
            end
        elseif x > rect_B(1) && x < rect_B(3) && y > rect_B(2) && y < rect_B(4)
            Screen('DrawTexture', wPtr, tex,[],rect_B2);
            Screen('DrawText',wPtr,'B',(rect_B(1) + rect_B(3))/2,(rect_B(2) + rect_B(4))/2,white);
            if buttons(1)
                card = 'B';
            end
        elseif x > rect_C(1) && x < rect_C(3) && y > rect_C(2) && y < rect_C(4)
            Screen('DrawTexture', wPtr, tex,[],rect_C2);
            Screen('DrawText',wPtr,'C',(rect_C(1) + rect_C(3))/2,(rect_C(2) + rect_C(4))/2,white);
            if buttons(1)
                card = 'C';
            end
        elseif x > rect_D(1) && x < rect_D(3) && y > rect_D(2) && y < rect_D(4)
            Screen('DrawTexture', wPtr, tex,[],rect_D2);
            Screen('DrawText',wPtr,'D',(rect_D(1) + rect_D(3))/2,(rect_D(2) + rect_D(4))/2,white);
            if buttons(1)
                card = 'D';
            end
        end

        %Change card graphic when "card" is set to a letter value, until another card is selected OR submit it pressed
        if card == 'A'
            Screen('DrawTexture', wPtr, tex,[],rect_A2);
            Screen('DrawText',wPtr,'A',(rect_A(1) + rect_A(3))/2,(rect_A(2) + rect_A(4))/2,white);
        elseif card == 'B'
            Screen('DrawTexture', wPtr, tex,[],rect_B2);
            Screen('DrawText',wPtr,'B',(rect_B(1) + rect_B(3))/2,(rect_B(2) + rect_B(4))/2,white);
        elseif card == 'C'
            Screen('DrawTexture', wPtr, tex,[],rect_C2);
            Screen('DrawText',wPtr,'C',(rect_C(1) + rect_C(3))/2,(rect_C(2) + rect_C(4))/2,white);
        elseif card == 'D'
            Screen('DrawTexture', wPtr, tex,[],rect_D2);
            Screen('DrawText',wPtr,'D',(rect_D(1) + rect_D(3))/2,(rect_D(2) + rect_D(4))/2,white);
        end

        %if submit button is scrolled over
        if x > rect_submit(1) && x < rect_submit(3) && y > rect_submit(2) && y < rect_submit(4)
            Screen('FillRect', wPtr, [155 155 155], rect_submit,5);
            Screen('DrawText',wPtr,'Submit',(rect_submit(1) + rect_submit(3))/2-50,(rect_submit(2) + rect_submit(4))/2-20,white);
            %if button is pressed while submit is highlighted
            if buttons(1)
                %update wins, loses and current total
                switch card
                    case 'A'
                        win(i) = A_win;
                        lose(i) = A_loseRand(A_counter);
                        currTot = currTot + A_win - A_loseRand(A_counter);
                        allCurrTot(i+1) = currTot;
                        dat.IGT.choices(i) = card;
                        dat.IGT.wins = win;
                        dat.IGT.loses = lose;
                        dat.IGT.totals = allCurrTot;
                        save(dat.filename, 'dat');
                        fprintf(fid,'selection for trial %d: A\n',i);
                    case 'B'
                        win(i) = B_win;
                        lose(i) = B_loseRand(B_counter);
                        currTot = currTot + B_win - B_loseRand(B_counter);
                        allCurrTot(i+1) = currTot;
                        dat.IGT.choices(i) = card;
                        dat.IGT.wins = win;
                        dat.IGT.loses = lose;
                        dat.IGT.totals = allCurrTot;
                        save(dat.filename, 'dat');
                        fprintf(fid,'selection for trial %d: B\n',i);
                    case 'C'
                        win(i) = C_win;
                        lose(i) = C_loseRand(C_counter);
                        currTot = currTot + C_win - C_loseRand(C_counter);
                        allCurrTot(i+1) = currTot;
                        dat.IGT.choices(i) = card;
                        dat.IGT.wins = win;
                        dat.IGT.loses = lose;
                        dat.IGT.totals = allCurrTot;
                        save(dat.filename, 'dat');
                        fprintf(fid,'selection for trial %d: C\n',i);
                    case 'D'
                        win(i) = D_win;
                        lose(i) = D_loseRand(D_counter);
                        currTot = currTot + D_win - D_loseRand(D_counter);
                        allCurrTot(i+1) = currTot;
                        dat.IGT.choices(i) = card;
                        dat.IGT.wins = win;
                        dat.IGT.loses = lose;
                        dat.IGTtotals = allCurrTot;
                        save(dat.filename, 'dat');
                        fprintf(fid,'selection for trial %d: D\n',i);
                    otherwise
                        win(i) = NaN;
                        lose(i) = NaN;
                        allCurrTot(i+1) = allCurrTot(i);
                        dat.IGT.choices(i) = card;
                        dat.IGT.wins = win;
                        dat.IGT.loses = lose;
                        dat.IGT.totals = allCurrTot;
                        save(dat.filename, 'dat');
                        fprintf(fid,'selection for trial %d: NA\n',i);
                        break;
                end
                break;
            end
        end
        Screen('Flip',wPtr);
    end
    cards(i) = card;
    WaitSecs(.5);  
end
dat.IGT.choices = cards;
dat.IGT.wins = win;
dat.IGT.loses = lose;
dat.IGT.totals = allCurrTot;
% allEnd = GetSecs;
save(dat.filename, 'dat');