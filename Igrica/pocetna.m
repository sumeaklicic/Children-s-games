classdef pocetna < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        PROFESORdrAdnanRamakiASISTENTICAmaUnaDrakuliSTUDENTICASumeaKlicic1285Label  matlab.ui.control.Label
        PogodizamisljenibrojButton  matlab.ui.control.Button
        Image3                      matlab.ui.control.Image
        UniverzitetuBihauTehnikifakultetBihaLabel  matlab.ui.control.Label
        PapirkamenmakazeButton      matlab.ui.control.Button
        Image2                      matlab.ui.control.Image
        MatematikazamkaButton       matlab.ui.control.Button
        Image                       matlab.ui.control.Image
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: MatematikazamkaButton
        function MatematikazamkaButtonPushed(app, event)

         MatematickaZamka;

        end

        % Button pushed function: PapirkamenmakazeButton
        function PapirkamenmakazeButtonPushed(app, event)
            pkm;
        end

        % Button pushed function: PogodizamisljenibrojButton
        function PogodizamisljenibrojButtonPushed(app, event)
            PogodiBroj; 
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [1 0.9882 0.7412];
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [82 258 161 136];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'matematika.png');

            % Create MatematikazamkaButton
            app.MatematikazamkaButton = uibutton(app.UIFigure, 'push');
            app.MatematikazamkaButton.ButtonPushedFcn = createCallbackFcn(app, @MatematikazamkaButtonPushed, true);
            app.MatematikazamkaButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.MatematikazamkaButton.FontSize = 18;
            app.MatematikazamkaButton.Position = [75 229 175 30];
            app.MatematikazamkaButton.Text = 'Matematička zamka';

            % Create Image2
            app.Image2 = uiimage(app.UIFigure);
            app.Image2.Position = [192 258 449 136];
            app.Image2.ImageSource = fullfile(pathToMLAPP, 'pkm.jpg');

            % Create PapirkamenmakazeButton
            app.PapirkamenmakazeButton = uibutton(app.UIFigure, 'push');
            app.PapirkamenmakazeButton.ButtonPushedFcn = createCallbackFcn(app, @PapirkamenmakazeButtonPushed, true);
            app.PapirkamenmakazeButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.PapirkamenmakazeButton.FontSize = 18;
            app.PapirkamenmakazeButton.Position = [325 229 202 30];
            app.PapirkamenmakazeButton.Text = 'Papir kamen makaze';

            % Create UniverzitetuBihauTehnikifakultetBihaLabel
            app.UniverzitetuBihauTehnikifakultetBihaLabel = uilabel(app.UIFigure);
            app.UniverzitetuBihauTehnikifakultetBihaLabel.Position = [1 451 124 30];
            app.UniverzitetuBihauTehnikifakultetBihaLabel.Text = {'Univerzitet u Bihaću'; 'Tehnički fakultet Bihać'};

            % Create Image3
            app.Image3 = uiimage(app.UIFigure);
            app.Image3.Position = [134 72 316 131];
            app.Image3.ImageSource = fullfile(pathToMLAPP, 'brojevi.jpg');

            % Create PogodizamisljenibrojButton
            app.PogodizamisljenibrojButton = uibutton(app.UIFigure, 'push');
            app.PogodizamisljenibrojButton.ButtonPushedFcn = createCallbackFcn(app, @PogodizamisljenibrojButtonPushed, true);
            app.PogodizamisljenibrojButton.BackgroundColor = [0.9294 0.6941 0.1255];
            app.PogodizamisljenibrojButton.FontSize = 18;
            app.PogodizamisljenibrojButton.Position = [162 43 264 30];
            app.PogodizamisljenibrojButton.Text = 'Pogodi zamisljeni broj';

            % Create PROFESORdrAdnanRamakiASISTENTICAmaUnaDrakuliSTUDENTICASumeaKlicic1285Label
            app.PROFESORdrAdnanRamakiASISTENTICAmaUnaDrakuliSTUDENTICASumeaKlicic1285Label = uilabel(app.UIFigure);
            app.PROFESORdrAdnanRamakiASISTENTICAmaUnaDrakuliSTUDENTICASumeaKlicic1285Label.Position = [449 422 216 59];
            app.PROFESORdrAdnanRamakiASISTENTICAmaUnaDrakuliSTUDENTICASumeaKlicic1285Label.Text = {'PROFESOR: dr. Adnan Ramakić'; 'ASISTENTICA: ma. Una Drakulić'; 'STUDENTICA: Sumea Klicic 1285'};

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = pocetna

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