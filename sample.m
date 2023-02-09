clear
clc

% LRFの初期化
lidar = serialport('COM5', 115200, Timeout=0.1); % COMポートを適宜変更してください
setURG(lidar);

hf = figure;
while true
    % LRFの点群を取得
    angles = deg2rad(-45:360/1440:225);
    ranges = LidarScan(lidar);
    x = ranges .* cos(angles);
    y = ranges .* sin(angles);

    % プロット
    clf
    hold on
    daspect([1 1 1])
    plot(x, y, '.')
    xlabel('x [mm]')
    ylabel('y [mm]')

    % 終了キーが押されたかの判定
    if strcmp(get(hf, 'currentcharacter'), 'q')
        close(hf)
        break
    end
end

writeline(lidar, 'QT'); % 計測停止
