# Contact-Usage
iOS 9.0以上系统通讯录使用，简单封装，方便使用。

### 写在前面的话
需要添加用户隐私授权描述Key:Privacy - Contacts Usage Description
代码已经验证了是否授权成功，并作出相应的处理。

### 联系人操作
创建默认的联系人
添加联系人
修改联系人
删除联系人
获取所有联系人数据

### 分组数据操作
新增分组
修改分组
删除分组
获取所有分组

### 系统选择/编辑联系人
CNContactPickerViewController
CNContactViewController
ps:需要在使用的viewController中添加对应的协议
无论是单选、多选、查看详情、编辑，都可以很快集成

示例代码：
``` 
[ContactManager getAllContacts];
...
```
