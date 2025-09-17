%40 MHz sample rate, 1/40 usec/sample, 160 samples/symbol, 4 usec duration
% 1/40 usec/sample, 128 samples/symbol, 3.2 usec transform segment
% spectral channel spacing 1/3.2 usec = 312.5 kHz

clear all; close all; clc;

%% SECTION A

x0=[]; % empty array for OFDM with Guard interval
y0=[]; % empty array for OFDM with cyclic prefices

for k=1:100    
    fxx=zeros(1,128);    
    dat=(floor(4*rand(1,54))-1.5)/1.5+j*(floor(4*rand(1,54))-1.5)/1.5;    
    fxx(65+(-27:27))=[dat(1:27) 0 dat(28:54)];    
    xx=8*ifft(fftshift(fxx));  

    x0=[x0 zeros(1,32) xx];    
    y0=[y0 xx(97:128) xx];
end

figure(1)

    subplot(3,1,1)
    
        plot(0:640, real(x0(1:641)),'b','linewidth',2)
        
        hold on
        for k=1:160:640    
            plot(k-1:k+30,real(x0(k:k+31)),'r','linewidth',2)
        end
        hold off
        
        grid on
        set(gca,'XTick', [0:32:640])
        axis([0 640 -1.2 1.2])
        title('Real Part 128 Point OFDM Signal, with 32 Sample Guard Intervals')
        xlabel('Time Index')
        ylabel('Amplitude')

    subplot(3,1,2)
    
        plot(0:640, imag(x0(1:641)),'b','linewidth',2)
        
        hold on
        for k=1:160:640    
            plot(k-1:k+30,imag(x0(k:k+31)),'r','linewidth',2)
        end
        hold off
        
        grid on
        set(gca,'XTick', [0:32:640])
        axis([0 640 -1.2 1.2])
        title('Imaginary Part 128 Point OFDM Signal, with 32 Sample Guard Intervals')
        xlabel('Time Index')
        ylabel('Amplitude')
    
    
    subplot(3,1,3)
    
        W_k = kaiser(length(x0), 8.3);
        ps = abs(fftshift(fft(x0'.*W_k, 2048))).^2;

        f = linspace(-0.5, 0.5, 2048);
        plot(f, 20*log10(ps/max(ps)));

        grid on
        title('Power spectrum of the time series')
        xlabel('Normalized Frequency')
        ylabel('Power')






%% SECTION B

figure(2)

    subplot(2,1,1)

        plot(0,0)

        hold on
        for n=1:160:16000-160
            x1=x0(n:n+159);
            fx1=fftshift(fft(x1(33:160)))/8;
            plot(-64:63,real(fx1),'ro','linewidth',2,'markersize',6)
        end
        hold off

        grid on
        axis([-32 32 -1.5 1.5])
        set(gca,'XTick',[-64:8:64])
        title('Real Part, FFT Transform Segments of OFDM Symbols')
     

    subplot(2,1,2)

        plot(0,0)

        hold on
        for n=1:160:16000-160
            x1=x0(n:n+159);
            fx1=fftshift(fft(x1(33:160)))/8;
            plot(fx1,'ro','linewidth',2,'markersize',6)
        end
        hold off

        grid on
        axis('equal')
        axis([-1.5 1.5 -1.5 1.5])


%% SECTION C

x0c = conv(x0, [1   0   0.2   0   0   0   0   0   0   j*0.1]);

figure(3)

    subplot(2,1,1)

        plot(0,0)

        hold on
        for n=1:160:16000-160
            x1=x0c(n:n+159);
            fx1=fftshift(fft(x1(33:160)))/8;
            plot(-64:63,real(fx1),'ro','linewidth',2,'markersize',6)
        end
        hold off

        grid on
        axis([-32 32 -1.5 1.5])
        set(gca,'XTick',[-64:8:64])
        title('Channel Distortion: Real Part, FFT Transform Segments of OFDM Symbols')
     

    subplot(2,1,2)

        plot(0,0)

        hold on
        for n=1:160:16000-160
            x1=x0c(n:n+159);
            fx1=fftshift(fft(x1(33:160)))/8;
            plot(fx1,'ro','linewidth',2,'markersize',6)
        end
        hold off

        grid on
        axis('equal')
        axis([-1.5 1.5 -1.5 1.5])



%% SECTION D

y0c = conv(y0, [1   0   0.2   0   0   0   0   0   0   j*0.1]);

figure(4)

subplot(2,1,1)

        plot(0,0)

        hold on
        for n=1:160:16000-160
            y1=y0c(n:n+159);
            fy1=fftshift(fft(y1(33:160)))/8;
            plot(-64:63,real(fy1),'ro','linewidth',2,'markersize',6)
        end
        hold off

        grid on
        axis([-32 32 -1.5 1.5])
        set(gca,'XTick',[-64:8:64])
        title('Cyclic Prefix: Real Part, FFT Transform Segments of OFDM Symbols')
     

    subplot(2,1,2)

        plot(0,0)

        hold on
        for n=1:160:16000-160
            y1=y0c(n:n+159);
            fy1=fftshift(fft(y1(33:160)))/8;
            plot(fy1,'ro','linewidth',2,'markersize',6)
        end
        hold off

        grid on
        axis('equal')
        axis([-1.5 1.5 -1.5 1.5])




%% SECTION E


%Pf = (floor(4*rand(1,52))-1.5)/1.5+j*(floor(4*rand(1,52))-1.5)/1.5;

fxx = zeros(1,128);

fxx(65+[-26:-1 1:26]) = 1.4;

P = ifft(fftshift(fxx), 128);

% P = zeros(1, 128);
% P(24:55) = 1;
% P(57:82) = 1;

cp = P(end-63:end);

z0 = [cp P P y0];

h = [1   0   0.2   0   0   0   0   0   0   j*0.1];

z0c = conv(z0, h);


figure(5)

    subplot(2, 1, 1)


        % channel
        ci = fftshift(fft(h, 128));        
        plot([-40:40], abs(ci(65+[-40:40])));

        hold on

        % preamble
        sent = fftshift(fft(P, 128));
        plot([-40:40], abs(sent(65 + [-40:40])));

        % recived
        prc = fftshift(fft(z0c(192:320), 128));
        plot([-40:40], abs(prc(65 + [-40:40])));

        hold off    


    subplot(2, 1, 2)

        % Channel estimate
        spec = prc./sent;
        spec(1:37) = zeros(1, 37);
        spec(92:128) = zeros(1, 37);

        plot([-40:40], abs(spec(65+[-40:40])));

        hold on
        % Channel impulse
        plot([-40:40], abs(ci(65+[-40:40])), 'r.');
        hold off




        
%% SECTION F
ci(1:37) = zeros(1, 37);
ci(92:128) = zeros(1, 37);

figure(6)
clf

subplot(3,1,1)

    plot(0,0)
    hold on
    % plot raw frequency bins
    for n=1:160:16000-160
        y1=y0c(n:n+159);
        fy1=fftshift(fft(y1(33:160)))/8;
        plot(-64:63,real(fy1),'bo','linewidth',2,'markersize',6)
    end
    % plot equalized frequency bins
    for n=1:160:16000-160
        y1=y0c(n:n+159);
        fy1=fftshift(fft(y1(33:160)))/8;
        fy1 = fy1./ci;
        plot(-64:63,real(fy1),'ro','linewidth',2,'markersize',6)
    end
    hold off
    grid on
    axis([-60 60 -1.5 1.5])
    set(gca,'XTick',[-64:8:64])
    title('Cyclic Prefix: Real Part, FFT Transform Segments of OFDM Symbols')


subplot(3,1,2)

    hold on;
    for n=1:160:16000-160
        y1 = y0c(n+32:n+159);
        fy1 = fftshift(fft(y1))/8; 
        fy1_eq = fy1 ./ ci;
        plot(fy1_eq, 'ro', 'linewidth', 1, 'markersize', 4)
    end
    hold off;
    grid on;
    axis('equal')
    axis([-1.5 1.5 -1.5 1.5])
    title('Equalized Constellation')
    xlabel('In-phase')
    ylabel('Quadrature')

% figure 7: Raw constellation
subplot(3, 1, 3)

    hold on;
    for n=1:160:16000-160
        y1 = y0c(n+32:n+159);
        fy1 = fftshift(fft(y1))/8;
        plot(fy1, 'bo', 'markersize', 4, 'linewidth', 1)
    end
    hold off;
    grid on;
    axis('equal')
    axis([-2 2 -2 2])
    title('Raw Constellation (Before Equalization)')
    xlabel('In-phase')
    ylabel('Quadrature')

   

%% SECTION G

