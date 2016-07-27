
@class NSString;

extern NSString * const SHBannerBasePathURLString;
extern NSString * const SHBrokenImageName;

#define RGB(r, g, b)                      \
[UIColor colorWithRed:((float)(r))/255.0f \
green:((float)(g))/255.0f                 \
blue:((float)(b))/255.0f                  \
alpha:1.0]                                