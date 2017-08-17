//
//  ContactManager.h
//  Contact Demo
//
//  Created by VinceJee on 2017/8/17.
//  Copyright © 2017年 VinceJee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ContactsUI/ContactsUI.h>

@interface ContactManager : NSObject


/**
 
 @abstract 创建默认的联系人
 
 @return 联系人
 */
+ (CNMutableContact *)createContactPerson;


/**
 添加联系人

 @param contact 联系人
 */
+ (void)addContact:(CNMutableContact *)contact;


/**
 修改联系人

 @param name 联系人名字
 */
+ (void)updateContactWithName:(NSString *)name;


/**
 删除联系人
 
 @param name 联系人名字
 */
+ (void)deleteContactWithName:(NSString *)name;


/**
 获取所有的联系人
 
 @return 联系人数据
 */
+ (NSArray *)getAllContacts;


/**
 获取所有的分组
 
 @return 分组信息
 */
+ (NSArray *)getAllGroups;


/**
 增加分组
 
 @param groupName 分组名
 */
+ (void)addGroupWithName:(NSString *)groupName;


/**
 修改分组
 
 @param groupName 原名字
 @param newName 新名字
 */
+ (void)updateGroupWithName:(NSString *)groupName newName:(NSString *)newName;


/**
 删除分组

 @param groupName 分组名字
 */
+ (void)deleteGroupWithName:(NSString *)groupName;


/**
 添加联系人到分组

 @param contact 联系人
 @param group 分组
 */
+ (void)moveContact:(CNContact *)contact toGroup:(CNGroup *)group;


/**
 显示选择联系人的控制器
 */
+ (void)showContactPickerViewControllerWithViewController:(id)viewCtl;


/**
 显示编辑联系人的控制器

 @param contact 联系人
 */
+ (void)showContactViewControllerWithContact:(CNContact *)contact viewController:(id)viewCtl;

@end
