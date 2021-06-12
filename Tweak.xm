#import <UIKit/UIKit.h>

static UIViewController *_topMostController(UIViewController *cont) {
    UIViewController *topController = cont;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    if ([topController isKindOfClass:[UINavigationController class]]) {
        UIViewController *visible = ((UINavigationController *)topController).visibleViewController;
        if (visible) {
            topController = visible;
        }
    }
    return (topController != cont ? topController : nil);
}
static UIViewController *topMostController() {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *next = nil;
    while ((next = _topMostController(topController)) != nil) {
        topController = next;
    }
    return topController;
}

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

    [topMostController() presentViewController:alert animated:true completion:nil];


  }




 }

%end
