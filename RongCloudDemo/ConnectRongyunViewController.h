

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>
/**
 *这个类不能被删除，因为在appDelegate文件中有一个检测网络状态的函数，当用户掉线，程序会启动这个界面让
 *用户重新登录
 */
@interface ConnectRongyunViewController : UIViewController<RCIMUserInfoDataSource>


@end

