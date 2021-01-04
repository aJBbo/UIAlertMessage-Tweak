#import <UIKit/UIKit.h>

%hook UIApplication
-(void)finishedTest:(id)arg1 extraResults:(id)arg2 {

  %orig;


UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hola" message:@"nil" preferredStyle:UIAlertControllerStyleAlert];

UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

 }];

[alert addAction:action];

[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];



 }

%end
