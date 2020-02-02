# PirateScan
 Gag application to trick people into thinking they've been caught pirating

Don't worry, this application is really harmless. You can see by the source code. It literally does nothing with anything. Just a silly little UI application, tricking you into thinking it detected pirated movies. It offers the user to either pay a fine, opening a credit card entry screen, or to face prison time. 

The credit card screen makes absolutely no use of the information - but does attempt to at least validate whether it's legit card information. And the only way to get the application to close is to choose prison time, in which case it reminds the user "Don't drop the soap!" just before closing.

## Application Launch

When you run this application, it simply shows the following dialog:

![alt text](/Img/ssMain.png)

If you choose to pay the fine, you are presented with a screen to enter your credit card information:

![alt text](/Img/ssCard.png)

This screen tries to validate the card info, but it does not save or submit it anywhere. It just pretends to try and process it, but then just declines the transaction.

If you choose to cancel, you are presented with this prompt:

![alt text](/Img/ssCardCancel.png)

If you decide to go with prison time, you are taken back to the prior window, which the only other option is to choose prison time. When you do so, you see this prompt again:

![alt text](/Img/ssPrison.png)

Once you agree, you finally see this last prompt before the application closes:

![alt text](/Img/ssSoap.png)

## Parameters

You can override the default amounts by providing parameters in the execution of the app.

Example: `PirateScan.exe -fine 250 -prison 20`

 - fine - The dollar amount of the fine.
 - prison - The number of years of prison time.

Enjoy!
