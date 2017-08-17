//
//  ContactManager.m
//  Contact Demo
//
//  Created by VinceJee on 2017/8/17.
//  Copyright © 2017年 VinceJee. All rights reserved.
//

#import "ContactManager.h"
#import <UIKit/UIKit.h>

@implementation ContactManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self anthorize];
    }
    return self;
}

#pragma mark - 授权
- (CNAuthorizationStatus)anthorize {
    // 授权
    return [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
}

#pragma mark - delete contact
+ (void)deleteContactWithName:(NSString *)name {
    
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    
    CNMutableContact *contact = [[[[self class] selectContactWithName:name] lastObject] mutableCopy];
    
    if (contact) {
        [request deleteContact:contact];
        printf("删除成功\n");
    } else {
        NSAssert(contact==nil, @"delete contact is nil");
    }
    
    [[self class] executeRequest:request];
    
}

#pragma mark - update contact
+ (void)updateContactWithName:(NSString *)name {
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    
    CNMutableContact *contact = [[[[self class] selectContactWithName:name] lastObject] mutableCopy];
    
    if (contact) {
        contact.givenName = [NSString stringWithFormat:@"new-%@",contact.givenName];
        [request updateContact:contact];
        printf("update成功\n");
    } else {
        NSAssert(contact==nil, @"update contact is nil");
    }
    
    [[self class] executeRequest:request];
}

#pragma mark - select contact 
- (NSArray *)selectContactWithName:(NSString *)name {
    
    NSPredicate *predicate = [CNContact predicateForContactsMatchingName:name];
    
    CNContactStore *store = [[CNContactStore alloc] init];
    
    NSError *err;
    return [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactGivenNameKey] error:&err];
}

#pragma mark - add contact
+ (void)addContact:(CNMutableContact *)contact {
    
    if (!contact) {
        NSAssert(contact==nil, @"add contact is nil");
     }
    
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    
    [request addContact:contact toContainerWithIdentifier:nil];
    
    [[self class] executeRequest:request];
    
}

- (void)executeRequest:(CNSaveRequest *)request {
    
    CNContactStore *store = [[CNContactStore alloc] init];
    
    NSError *err;
    if([store executeSaveRequest:request error:&err]) {
        printf("保存成功\n");
    } else {
        printf("保存失败\n");
    }
}


#pragma mark - all contacts
+ (NSArray *)getAllContacts {
    CNContactStore *store = [[CNContactStore alloc] init];
    
    CNAuthorizationStatus status = [[self class] anthorize];
    
    if (status) {
        
        NSMutableArray *contacts = [@[] mutableCopy];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                
                NSArray *arr = @[CNContactGivenNameKey];
                
                CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch: arr];
                request.sortOrder = CNContactSortOrderFamilyName;
                
                [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                    [contacts addObject:contact];
                }];
            }
        }];
        return contacts;
    }
    
    NSAssert(status==NO, @"authorized error");
    return nil;
}

#pragma mark - create contact persopn
// 默认值，可自定义修改，只需要填写主要的参数. eg:name phoneNumber and so on.
+ (CNMutableContact *)createContactPerson {
    
    CNMutableContact *contact = [[CNMutableContact alloc] init];
    
    // 联系人类型
    contact.contactType = CNContactTypePerson;
    
    //名字前缀
    contact.namePrefix = @"namePrefix";
    
    // 真实名
    contact.givenName = @"givenName";
    
    // 中间名 一般是外国人才有
    contact.middleName = @"middleName";
    
    // 姓名
    contact.familyName = @"familyName";
    
    // 前一个姓名
    contact.previousFamilyName = @"previousFalimyName";
    
    // 名字后缀
    contact.nameSuffix = @"nameSuffix";
    
    // 昵称
    contact.nickname = @"nickName";
    
    // 组织名称
    contact.organizationName = @"organizationName";
    
    // 公寓名
    contact.departmentName = @"departmentName";
    
    
    contact.jobTitle = @"jobTitle";
    contact.phoneticGivenName = @"phoneticGivenName";
    contact.phoneticMiddleName = @"phoneticMiddleName";
    contact.phoneticFamilyName = @"phoneticFamilyName";
    contact.phoneticOrganizationName = @"phoneticOrganizationName";
    
    // 备注
    contact.note = @"note";
    
    // 头像
    contact.imageData = UIImagePNGRepresentation([UIImage imageNamed:@"icon.png"]);
    
    // 手机
    CNPhoneNumber *phoneNumber = [[CNPhoneNumber alloc] initWithStringValue:@"15800000000"];
    CNLabeledValue *phoneValue = [[CNLabeledValue alloc] initWithLabel:CNLabelPhoneNumberMobile value:phoneNumber];
    contact.phoneNumbers = @[phoneValue];
    
    // email
    CNLabeledValue *homeValue = [[CNLabeledValue alloc] initWithLabel:CNLabelHome value:@"home@gmail.com"];
    CNLabeledValue *workValue = [[CNLabeledValue alloc] initWithLabel:CNLabelWork value:@"work@gmail.com"];
    CNLabeledValue *otherValue = [[CNLabeledValue alloc] initWithLabel:CNLabelOther value:@"other@gmail.com"];
    contact.emailAddresses = @[homeValue, workValue, otherValue];
    
    // 邮递地址
    CNMutablePostalAddress *postalAddress = [[CNMutablePostalAddress alloc] init];
    postalAddress.street = @"street";
    postalAddress.state = @"state";
    postalAddress.city = @"city";
    postalAddress.country = @"country";
    postalAddress.postalCode = @"postalCode";
    postalAddress.ISOCountryCode = @"countryCode";
    
    CNLabeledValue *postalValue = [[CNLabeledValue alloc] initWithLabel:CNContactPostalAddressesKey value:postalAddress];
    contact.postalAddresses = @[postalValue];
    
    // 个人主页
    CNLabeledValue *urlAddress = [[CNLabeledValue alloc] initWithLabel:CNLabelURLAddressHomePage value:@"https://www.baidu.com/cn"];
    contact.urlAddresses = @[urlAddress];
    
    // 关联联系人
    CNContactRelation *contactRelation = [[CNContactRelation alloc] initWithName:@"father"];
    CNLabeledValue *contactRelationValue = [[CNLabeledValue alloc] initWithLabel:CNLabelContactRelationFather value:contactRelation];
    contact.contactRelations = @[contactRelationValue];
    
    // 社交
    CNSocialProfile *socialProfile = [[CNSocialProfile alloc] initWithUrlString:@"https://www.baidu.com" username:@"userName" userIdentifier:@"userId" service:nil];
    CNLabeledValue *socialValue = [[CNLabeledValue alloc] initWithLabel:CNSocialProfileServiceGameCenter value:socialProfile];
    contact.socialProfiles = @[socialValue];
    
    // 即时通讯
    CNInstantMessageAddress *instantMessageAddress = [[CNInstantMessageAddress alloc] initWithUsername:@"username_qq" service:@""];
    CNLabeledValue *instantValue = [[CNLabeledValue alloc] initWithLabel:CNInstantMessageServiceQQ value:instantMessageAddress];
    contact.instantMessageAddresses = @[instantValue];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = 1992;
    components.month = 9;
    components.day = 10;
    
    // 生日
    contact.birthday = components;
    
    // 纪念日
    CNLabeledValue *datesValue = [[CNLabeledValue alloc] initWithLabel:CNLabelDateAnniversary value:components];
    contact.dates = @[datesValue];
    
    return contact;
}

#pragma mark - add group
+ (void)addGroupWithName:(NSString *)groupName {
    
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    
    CNMutableGroup *group = [[CNMutableGroup alloc] init];
    group.name = groupName;
    
    [request addGroup:group toContainerWithIdentifier:nil];
    
    [[self class] executeRequest:request];
}


#pragma mark - update group name

+ (void)updateGroupWithName:(NSString *)groupName newName:(NSString *)newName {
    
    NSArray *groups = [self getAllGroups];
    
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    
    for (CNGroup *obj in groups) {
        if ([obj.name isEqualToString:groupName]) {
            CNMutableGroup *group = [obj mutableCopy];
            group.name = newName;
            [request updateGroup:group];
            break;
        }
    }
    
    [[self class] executeRequest:request];
}


#pragma mark -  delete group 
+ (void)deleteGroupWithName:(NSString *)groupName {
    
    NSArray *groups = [self getAllGroups];
    
    CNSaveRequest *request = [[CNSaveRequest alloc] init];
    
    for (CNGroup *obj in groups) {
        if ([obj.name isEqualToString:groupName]) {
            CNMutableGroup *group = [obj mutableCopy];
             [request deleteGroup:group];
            break;
        }
    }
    
    [[self class] executeRequest:request];
}

#pragma mark - move contact to group
+ (void)moveContact:(CNContact *)contact toGroup:(CNGroup *)group {
    
     CNSaveRequest *request = [[CNSaveRequest alloc] init];
    
    if (contact) {
        [request addMember:contact toGroup:group];
         [[self class] executeRequest:request];
    } else {
        NSAssert(contact=nil, @"moved contact is nil");
    }
}


#pragma mark - get all group

+ (NSArray *)getAllGroups {
    
    CNContactStore *store = [[CNContactStore alloc] init];
    NSError *err;
    NSArray *groups = [store groupsMatchingPredicate:nil error:&err];
    if (err) {
        NSAssert(err==nil, @"get all groups occur error");
    }
    
    return groups;
}

+ (void)showContactPickerViewControllerWithViewController:(id)viewCtl {
    
    CNContactPickerViewController *cn = [[CNContactPickerViewController alloc] init];
    cn.delegate = viewCtl;
    [viewCtl presentViewController:cn animated:YES completion:nil];
    
}

+ (void)showContactViewControllerWithContact:(CNContact *)contact viewController:(id)viewCtl {
    CNContactViewController *cn = [CNContactViewController viewControllerForNewContact:[self createContactPerson]];
    cn.allowsActions = YES;
    cn.delegate = viewCtl;
    UIViewController *vc = viewCtl;
    [vc.navigationController pushViewController:cn animated:YES];
}


@end
