#import <UIKit/UIKit.h>

%hook UIApplication
-(void)finishedTest:(id)arg1 extraResults:(id)arg2 {

  %orig;
  if (![[NSUserDefaults standardUserDefaults] objectForKey:@"FirstLaunch"]) {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hola" message:@"nil" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *twitter = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    // Open URL 
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://twitter.com/ajbbocydia"] options:@{} completionHandler:nil];
    
    // // // //
      [[NSUserDefaults standardUserDefaults] setValue:@"AlreadyLaunch" forKey:@"FirstLaunch"];
      [[NSUserDefaults standardUserDefaults] synchronize];
     }];
     
    UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      [[NSUserDefaults standardUserDefaults] setValue:@"AlreadyLaunch" forKey:@"FirstLaunch"];
      [[NSUserDefaults standardUserDefaults] synchronize];
     }];

    [alert addAction:twitter];
    [alert addAction:dismiss];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:true completion:nil];


  }




 }

%end
