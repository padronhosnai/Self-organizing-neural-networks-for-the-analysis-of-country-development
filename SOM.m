%% Load the data
data = normalisation_minmax(xlsread('Data.xlsx'));
%% Remove some indicators that have a strong correlation
time_periods = 13;
indicator_number = size(data,1);
%% Reshape the data in a per-country basis
input_per_country = reshape(data, [indicator_number,time_periods,size(data,2)/time_periods]);
        
%% Create the Self-Organizing Map
dimension1 = 30;
dimension2 = 20;
net = newsom(data,[dimension1 dimension2]);
% Use hexagonal topology
%%
net.adaptFcn = 'learnsom';
net.trainFcn = 'trainr';
net.trainParam.LP.order_steps = 5000;
net.trainParam.epochs = 50000;
%% Train the Network
[net,tr] = train(net,data);
%% Plot the activated neurons for each country
%for i = 1:length(countries)
%   %figure, plotsomhits(net,input_per_country(:,:,i)), title(countries(i));
%end

fileNames = [string('spain.csv'),string('cuba.csv'),string('dominican_republic.csv'),...
            string('mexico.csv'),string('colombia.csv'),string('venezuela.csv'),...
            string('argentina.csv'),string('uruguay.csv'),string('chile.csv'),...
            string('bolivia.csv'),string('puerto_rico.csv'),string('paraguay.csv'),...
            string('el_salvador.csv'),string('honduras.csv'),string('ecuador.csv'),...
            string('peru.csv'),string('panama.csv')];
years = [2000:2012];
for index = 1:17
    Out = sim(net, input_per_country(:,:,index));
    Neurons = vec2ind(Out)-1;
    NeuronsRow = fix(Neurons/dimension1);
    NeuronsCol = mod(Neurons,dimension1);
    Coords = [years;NeuronsCol;NeuronsRow];
    csvwrite(fileNames(index),Coords);
end