//
//  ListItem.m
//  Demo
//
//  Created by 崔婉莹 on 2022/1/20.
//

#import "ListItem.h"

@implementation ListItem

#pragma mark - NSSecureCoding
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super self];
    if(self){
        self.category = [aDecoder decodeObjectForKey:@"category"];
        self.picURL = [aDecoder decodeObjectForKey:@"picURL"];
        self.uniqueKey = [aDecoder decodeObjectForKey:@"uniqueKey"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.authorName = [aDecoder decodeObjectForKey:@"authorName"];
        self.articleURL = [aDecoder decodeObjectForKey:@"articleURL"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.category forKey:@"category"];
    [aCoder encodeObject:self.picURL forKey:@"picURL"];
    [aCoder encodeObject:self.uniqueKey forKey:@"uniqueKey"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.authorName forKey:@"authorName"];
    [aCoder encodeObject:self.articleURL forKey:@"articleURL"];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

#pragma mark - public method
- (void)configWithDictionary:(NSDictionary *)dictionary{
#warning 类型是否匹配
    self.category = [dictionary objectForKey:@"category"];
    self.picURL = [dictionary objectForKey:@"thumbnail_pic_s"];
    self.uniqueKey = [dictionary objectForKey:@"uniquekey"];
    self.title = [dictionary objectForKey:@"title"];
    self.date = [dictionary objectForKey:@"date"];
    self.authorName = [dictionary objectForKey:@"author_name"];
    self.articleURL = [dictionary objectForKey:@"url"];
}

@end
