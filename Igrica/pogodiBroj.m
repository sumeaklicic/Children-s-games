classdef pogodiBroj < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure               matlab.ui.Figure
        ProvjeriButton         matlab.ui.control.Button
        ZamisljenibrojjeLabel  matlab.ui.control.Label
        EditField              matlab.ui.control.EditField
        Zamisljenjebrojizmedu1i100PokusajtegapogoditiLabel  matlab.ui.control.Label
    end

   
    properties (Access = private)
        ZamisljenBroj  %onaj kojeg racunar izabere
        Pokusaji = 0 %da bi se na kraju ispisalo nakon koliko pokusaja je pogoden broj

    end
    
    methods (Access = private)
        %nakon sto se izabere da ne zelimo nastavak vracami se na glavni
        %prozor
        
        function povratakNaGlavni(app)
        % Zatvori trenutni prozor
        delete(app.UIFigure);
        igrica; %ime glavnog dijela
    end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
        app.ZamisljenBroj = randi([1 100]); %ovo je kao konstruktor za nasu klasu za aplikaciju i odmah tu je potrebno
        %da se generise broj da bi korisnik mogao pogadati
        app.ZamisljenibrojjeLabel.Text = 'Unesite broj i kliknite Provjeri.';
        app.Pokusaji = 0; %stavi se da je 0 na pocetki
        end

        % Button pushed function: ProvjeriButton
        function ProvjeriButtonPushed(app, event)

    
        unosStr = app.EditField.Value;
        broj = str2double(unosStr); %pretvaranje stringa u double

        if isnan(broj) || broj < 1 || broj > 100 %provjera da li je broj u odgovarajucem opsegu od 1 do 100
         uialert(app.UIFigure, 'Molim unesite cijeli broj između 1 i 100!', 'Nevažeći unos');
        return
       end

    app.Pokusaji = app.Pokusaji + 1; %povecava se broj pokusaja

    if broj == app.ZamisljenBroj %ako je unijeti broj jednak zamislenom
        app.ZamisljenibrojjeLabel.Text = ['Tačno! Pogodili ste broj u ', num2str(app.Pokusaji), ' pokušaja.'];
        %Ovaj tekst se ispise u labelu ispod
        % Prikaz opcije za nastavak ili izlaz
        izbor = questdlg(['Čestitamo! Pogodili ste broj ', num2str(app.ZamisljenBroj), ...%gornji dio prozora
            ' u ', num2str(app.Pokusaji), ' pokušaja. Želite li igrati ponovo?'], ...
            'Pobjeda!', ...
            'Da', 'Ne', 'Da');

        switch izbor %zavisi od izbora na prozoru
            case 'Da'
                % Pokreni novu igru - resetuj broj i pokušaje
                app.ZamisljenBroj = randi([1 100]);
                app.Pokusaji = 0;
                app.ZamisljenibrojjeLabel.Text = 'Unesite broj i kliknite Provjeri.';
            case 'Ne'
                %Zatvara se prozor gdje je bila igrica i otvara glavni
                %prozor
                delete(app.UIFigure);
                igrica();
        end

    elseif broj < app.ZamisljenBroj
        app.ZamisljenibrojjeLabel.Text = 'Zamisljen broj je veći.'; %ispis u zavisnosti da li je zamisljeni veci
        %ili manji od unijetog
    else
        app.ZamisljenibrojjeLabel.Text = 'Zamisljen broj je manji.';
    end

    app.EditField.Value = ''; % prazno polje za novi unos

        
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.949 0.9333 0.6745];
            app.UIFigure.Position = [100 100 658 273];
            app.UIFigure.Name = 'MATLAB App';

            % Create Zamisljenjebrojizmedu1i100PokusajtegapogoditiLabel
            app.Zamisljenjebrojizmedu1i100PokusajtegapogoditiLabel = uilabel(app.UIFigure);
            app.Zamisljenjebrojizmedu1i100PokusajtegapogoditiLabel.FontSize = 24;
            app.Zamisljenjebrojizmedu1i100PokusajtegapogoditiLabel.Position = [14 172 597 31];
            app.Zamisljenjebrojizmedu1i100PokusajtegapogoditiLabel.Text = 'Zamisljen je broj izmedu 1 i 100. Pokusajte ga pogoditi';

            % Create EditField
            app.EditField = uieditfield(app.UIFigure, 'text');
            app.EditField.Position = [14 112 597 22];

            % Create ZamisljenibrojjeLabel
            app.ZamisljenibrojjeLabel = uilabel(app.UIFigure);
            app.ZamisljenibrojjeLabel.FontSize = 18;
            app.ZamisljenibrojjeLabel.Position = [14 15 411 23];
            app.ZamisljenibrojjeLabel.Text = 'Zamisljeni broj je: ';

            % Create ProvjeriButton
            app.ProvjeriButton = uibutton(app.UIFigure, 'push');
            app.ProvjeriButton.ButtonPushedFcn = createCallbackFcn(app, @ProvjeriButtonPushed, true);
            app.ProvjeriButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.ProvjeriButton.FontSize = 18;
            app.ProvjeriButton.FontColor = [1 1 1];
            app.ProvjeriButton.Position = [423 63 188 30];
            app.ProvjeriButton.Text = 'Provjeri';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = pogodiBroj

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