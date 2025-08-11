classdef papirKamenMakaze < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        Label                  matlab.ui.control.Label
        RacunarovizborjeLabel  matlab.ui.control.Label
        TvojizborjeLabel       matlab.ui.control.Label
        IZABERITELabel         matlab.ui.control.Label
        Button_3               matlab.ui.control.Button
        Button_2               matlab.ui.control.Button
        Button                 matlab.ui.control.Button
        PAPIRKAMENMAKAZELabel  matlab.ui.control.Label
    end

    
    properties (Access = private)
         BrojPobjeda = 0; %varijabla za brojanje pobjeda
    end
    
    methods (Access = private)

    function obradiPotez(app, korisnik)
        opcije = {'papir', 'kamen', 'makaze'}; %niz od svih mogucih opcija koje racunar moze izabrati
        racunar = opcije{randi(3)};  % Računar nasumično bira jedno od 3

        % Prikaz izbora korisnika i računara
        app.TvojizborjeLabel.Text = ['Tvoj izbor je: ', korisnik]; 
        app.RacunarovizborjeLabel.Text = ['Računarov izbor je: ', racunar];

        % Provjera odabrano, u ova tri slucaja pobjeduje korisnik
        if (strcmp(korisnik, 'papir') && strcmp(racunar, 'kamen')) || ...
           (strcmp(korisnik, 'kamen') && strcmp(racunar, 'makaze')) || ...
           (strcmp(korisnik, 'makaze') && strcmp(racunar, 'papir'))
           %ispisuje se poruka da je pobijedio korisnik
            app.Label.Text = "Pobijedio si! Igraj ponovo.";
            app.BrojPobjeda = app.BrojPobjeda + 1; %povecava se broj pobjeda

        elseif strcmp(korisnik, racunar) %poredi se izbor korisnika i racunara, ako je isto situacija je nerijesena
            app.Label.Text = "Neriješeno!";

        else %ako korisnik nije pobijedio, nisu isti izbori znaci da je korisnik izubio
            app.Label.Text = ['Izgubio si. Ukupno pobjeda: ', num2str(app.BrojPobjeda)];
            izbor = uiconfirm(app.UIFigure, ... %skocni prozor koji se pojavi kada korisnik izgubi
                'Želiš li pokušati ponovo?', ...
                'Kraj igre', ...
                'Options', {'Pokušaj ponovo', 'Izađi'}, ... %dvije opcije u slucaju gubitka
                'DefaultOption', 1, ...
                'CancelOption', 2);

            if strcmp(izbor, 'Pokušaj ponovo') %znaci da se ponovo igra
                app.BrojPobjeda = 0; %resetuje se broj pobjeda na 0
                app.Label.Text = 'Igra počinje ponovo!';
            else
                delete(app.UIFigure);  % Zatvori aplikaciju ako korisnik izabe da zeli izaći
            end
        end
    end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: Button_3
        function Button_3Pushed(app, event)
             korisnik = 'makaze'; %ako klikne na 3 button njegova opcija su makaze
             obradiPotez(app, korisnik); %odraduje se potez shodno tome koju opciju je korisnik unio

        end

        % Button pushed function: Button_2
        function Button_2Pushed(app, event)
           
                korisnik = 'kamen';
                obradiPotez(app, korisnik);
           

        end

        % Button pushed function: Button
        function ButtonPushed(app, event)

    korisnik = 'papir';
    obradiPotez(app, korisnik);


        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.9804 0.9647 0.6745];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create PAPIRKAMENMAKAZELabel
            app.PAPIRKAMENMAKAZELabel = uilabel(app.UIFigure);
            app.PAPIRKAMENMAKAZELabel.BackgroundColor = [0.9294 0.6941 0.1255];
            app.PAPIRKAMENMAKAZELabel.FontSize = 48;
            app.PAPIRKAMENMAKAZELabel.FontColor = [1 1 1];
            app.PAPIRKAMENMAKAZELabel.Position = [56 403 551 63];
            app.PAPIRKAMENMAKAZELabel.Text = 'PAPIR KAMEN MAKAZE';

            % Create Button
            app.Button = uibutton(app.UIFigure, 'push');
            app.Button.ButtonPushedFcn = createCallbackFcn(app, @ButtonPushed, true);
            app.Button.BackgroundColor = [0.9294 0.6941 0.1255];
            app.Button.FontSize = 48;
            app.Button.Position = [56 258 95 70];
            app.Button.Text = '📄';

            % Create Button_2
            app.Button_2 = uibutton(app.UIFigure, 'push');
            app.Button_2.ButtonPushedFcn = createCallbackFcn(app, @Button_2Pushed, true);
            app.Button_2.BackgroundColor = [0.9294 0.6941 0.1255];
            app.Button_2.FontSize = 48;
            app.Button_2.Position = [269 258 104 70];
            app.Button_2.Text = '🪨';

            % Create Button_3
            app.Button_3 = uibutton(app.UIFigure, 'push');
            app.Button_3.ButtonPushedFcn = createCallbackFcn(app, @Button_3Pushed, true);
            app.Button_3.BackgroundColor = [0.9294 0.6941 0.1255];
            app.Button_3.FontSize = 48;
            app.Button_3.Position = [483 258 99 70];
            app.Button_3.Text = '✂️ ';

            % Create IZABERITELabel
            app.IZABERITELabel = uilabel(app.UIFigure);
            app.IZABERITELabel.FontSize = 24;
            app.IZABERITELabel.Position = [56 345 129 31];
            app.IZABERITELabel.Text = 'IZABERITE';

            % Create TvojizborjeLabel
            app.TvojizborjeLabel = uilabel(app.UIFigure);
            app.TvojizborjeLabel.FontSize = 18;
            app.TvojizborjeLabel.Position = [56 203 470 23];
            app.TvojizborjeLabel.Text = 'Tvoj izbor je: ';

            % Create RacunarovizborjeLabel
            app.RacunarovizborjeLabel = uilabel(app.UIFigure);
            app.RacunarovizborjeLabel.FontSize = 18;
            app.RacunarovizborjeLabel.Position = [56 148 504 23];
            app.RacunarovizborjeLabel.Text = 'Racunarov izbor je:';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.Position = [56 84 561 22];
            app.Label.Text = '';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = papirKamenMakaze

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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