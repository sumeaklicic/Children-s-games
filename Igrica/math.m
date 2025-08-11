classdef math < matlab.apps.AppBase
    %MATH konstruktor

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                 matlab.ui.Figure
        BROJTACNIHODGOVORALabel  matlab.ui.control.Label
        BROJIVOTALabel           matlab.ui.control.Label
        Button_3                 matlab.ui.control.Button
        Button_2                 matlab.ui.control.Button
        Button                   matlab.ui.control.Button
        PITANJELabel             matlab.ui.control.Label
        Label                    matlab.ui.control.Label
    end


    % Public properties that correspond to the Simulink model
    properties (Access = public, Transient)
        Simulation simulink.Simulation
    end

    
    %U ovom dijelu koda inicijalizujemo naše varijable sa početnim
    %vrijednostima
    properties (Access = private)
    zivot double = 3;                % Broj preostalih zivota, počinje se sa 3
    tacniOdgovori double = 0;        % Broj tacnih odgovora, kreće od 0
    trenutnoTacno char              % Trenutno tačnan odgovor da bi mogli porediti
    end
    
    
    methods (Access = private)


function initializeGame(app)
    % Resetuje stanje igre, to su varijable koje su gore definisane
    app.zivot = 3;
    app.tacniOdgovori = 0;

    % Ažurira tekstualne oznake
    app.BROJIVOTALabel.Text = ['Broj života: ' num2str(app.zivot)];
    app.BROJTACNIHODGOVORALabel.Text = ['Broj tačnih odgovora: ' num2str(app.tacniOdgovori)];

    % Postavi prvo pitanje
    postaviPitanje(app);
end



%Funkcija koja sluzi da se postavi naredno matematicko pitanje
function postaviPitanje(app)
    % Generiši dva nasumična broja i nasumičnu operaciju
    a = randi([1 10]); %bilo koji broj od 1 do 10
    b = randi([1 10]);
    operacije = {'+', '-', '*'}; %vektor sa operacijama
    op = operacije{randi(3)}; %rendom znak iz naseg niza svih operacija
    
    % Izračunaj tačan odgovor
    switch op %u zavisnosti od operacije koja je spremljena u varijablu op gledamo koji je tacan odgvor
        case '+'
            tacan = a + b;
        case '-'
            tacan = a - b;
        case '*'
            tacan = a * b;
    end

    % Sacuvan tacni odgvor
    app.trenutnoTacno = num2str(tacan);

    % Generiše 2 pogrešna odgovora na nasumican nacin
    netacni = [tacan + randi([1 5]), tacan - randi([1 5])]; %ovo je algoritam na koji se generise novi broj
    %s tim da nije nuzno da se odradi ovako vec mozemo i na bilo koji
    %zeljeni nacin
    while netacni(1) == tacan %ako je ipak tacan nastavlja se dodavanjem
        netacni(1) = tacan + randi([1 5]);
    end
    while netacni(2) == tacan || netacni(2) == netacni(1) %odraduje se isto za drugi netecan odgvoor
        netacni(2) = tacan - randi([1 5]);
    end

    % Mijesanje tačnih i netacnih odgovora da ne bi uvijek tacni bili na
    % istom mjestu
    svi = [tacan, netacni];
    svi = svi(randperm(3)); % nasumičan raspored

    % Prikaz na ekranu, kupe se sad sredeni podaci
    app.PITANJELabel.Text = sprintf('%d %s %d = ?', a, op, b);
    app.Button.Text = num2str(svi(1));
    app.Button_2.Text = num2str(svi(2));
    app.Button_3.Text = num2str(svi(3));
end
    
    %Provjerava klikuno i ono sto je tacno
    function provjeriOdgovor(app, odgovor)
    if strcmp(odgovor, app.trenutnoTacno) %poredi
        app.tacniOdgovori = app.tacniOdgovori + 1; %ako je tacno povecava se broj tacnih odgovora
        app.BROJTACNIHODGOVORALabel.Text = ['Broj tačnih odgovora: ' num2str(app.tacniOdgovori)]; %U labelu se mijenja broj
    else
        app.zivot = app.zivot - 1; %ako odgovor nije tacan oduzima se jedan zivot
        app.BROJIVOTALabel.Text = ['Broj života: ' num2str(app.zivot)]; %mijenja se vrijednost u labelu gdje pise broj zivota
    end

    if app.zivot == 0 %nakon sto tri puta izgubilo broj zivota ce doci na 0, a to je kraj igre
        uialert(app.UIFigure, 'Izgubili ste igru!', 'Kraj igre');
        igrica; %vracanje na pocetni prozor
        app.Button.Enable = 'off';
        app.Button_2.Enable = 'off';
        app.Button_3.Enable = 'off';
        return;
    end

    % Novi zadatak
    app.postaviPitanje(); %ako se ne ude u prethodni uslov znaci da nije 0 broj zivota pa se postavlja novo pitanje
end
    end
            
          
    

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
        initializeGame(app); %posto ne mogu pristupiti konstruktoru na ovaj nacin pokrecem program, to je
        %callbacks metoda
        end

        % Button pushed function: Button
        function ButtonPushed(app, event)
            app.provjeriOdgovor(app.Button.Text);  % provjeri odgovor na osnovu teksta dugmeta
            %Kad se klikne na odredeno dugme cilj je provjeriti da li je
            %odgovor tacan tako da pozivam gore napisanu funkciju
        end

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
                    app.provjeriOdgovor(app.Button_2.Text);  % provjeri odgovor na osnovu teksta dugmeta
        end

        % Button pushed function: Button_3
        function Button_3Pushed(app, event)
                    app.provjeriOdgovor(app.Button_3.Text);  % provjeri odgovor na osnovu teksta dugmeta
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.9765 0.9804 0.6941];
            app.UIFigure.Position = [100 100 709 282];
            app.UIFigure.Name = 'MATLAB App';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.Position = [17 248 640 22];
            app.Label.Text = 'Redom će se pojavljivati zadaci sa tri ponuđena odgovora. Nakon što tri puta pogriješite gubite pravo za nastavkom igre';

            % Create PITANJELabel
            app.PITANJELabel = uilabel(app.UIFigure);
            app.PITANJELabel.Position = [31 149 192 36];
            app.PITANJELabel.Text = 'PITANJE:';

            % Create Button
            app.Button = uibutton(app.UIFigure, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.BackgroundColor = [0.9294 0.6941 0.1255];
            app.Button.Position = [30 65 132 51];
            app.Button.Text = '';

            % Create Button_2
            app.Button_2 = uibutton(app.UIFigure, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.BackgroundColor = [0.9294 0.6941 0.1255];
            app.Button_2.Position = [200 65 141 51];
            app.Button_2.Text = '';

            % Create Button_3
            app.Button_3 = uibutton(app.UIFigure, 'push');
            app.Button_3.ButtonPushedFcn = createCallbackFcn(app, @Button_3Pushed, true);
            app.Button_3.BackgroundColor = [0.9294 0.6941 0.1255];
            app.Button_3.Position = [385 65 142 51];
            app.Button_3.Text = '';

            % Create BROJIVOTALabel
            app.BROJIVOTALabel = uilabel(app.UIFigure);
            app.BROJIVOTALabel.Position = [31 17 83 22];
            app.BROJIVOTALabel.Text = 'BROJ ŽIVOTA';

            % Create BROJTACNIHODGOVORALabel
            app.BROJTACNIHODGOVORALabel = uilabel(app.UIFigure);
            app.BROJTACNIHODGOVORALabel.Position = [340 17 158 22];
            app.BROJTACNIHODGOVORALabel.Text = 'BROJ TACNIH ODGOVORA';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = math

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end