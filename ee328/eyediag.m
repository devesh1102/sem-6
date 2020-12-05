clear


%pkg load signal;
BITS_PER_SYMBOL = 3;
NOISEVAR = 0.0000005;
channelresp = [1 0.2];
N = 500;

PAMLEVEL = 2^BITS_PER_SYMBOL;

t = -3:0.01:3;
p = sinc(t * 2);
symbols = randi([0 PAMLEVEL - 1], N, 1) - (PAMLEVEL - 1) / 2;
symbols_up = zeros(N * length(t), 1);
symbols_up(1:length(t):end) = symbols
symbols_up = conv(symbols_up, p);
recv_symbols = conv(symbols_up, upsample(channelresp, length(t)));
recv_symbols = recv_symbols + sqrt(NOISEVAR) * randn(size(recv_symbols));

offset = floor(length(t) / 2);

for i=1:N
  plot(recv_symbols((i - 1) * length(t) + offset - 60:i * length(t)- offset + 60), 'g-'); hold on;
end;
 hold off