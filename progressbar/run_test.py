from progressbar import (ProgressBar, Bar, ETA, FileTransferSpeed,
                         Percentage, RotatingMarker)


widgets = ['Test: ', Percentage(), ' ', Bar(marker=RotatingMarker()),
           ' ', ETA(), ' ', FileTransferSpeed()]
pbar = ProgressBar(widgets=widgets, maxval=10000000).start()
for i in range(1000000):
    # do something
    pbar.update(10*i+1)
pbar.finish()
print()
