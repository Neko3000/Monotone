
![License: MIT](https://img.shields.io/github/license/Neko3000/Monotone)
![Platforms: iOS](https://img.shields.io/badge/Platform-iOS-lightgrey)
![Language: Swift](https://img.shields.io/badge/language-swift-orange.svg)
![Version: v1.0](https://img.shields.io/badge/version-v1.0-lightgrey)

<h1 align="left">Monotone</h1>
<p align="center">
    <img width="600" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/poster.png">
</p>
<p align="center">
    <p align="center">
        <span href="#">English</span>
        ·
        <a href="https://github.com/Neko3000/Monotone/blob/master/README_CN.md">中文</a>
    </p>
    <p align="center">
        <a href="https://github.com/Neko3000/Monotone/issues">Report Bug</a>
        ·
        <a href="https://github.com/Neko3000/Monotone/issues">Request Feature</a>
    </p>
</p>

<br/>
<br/>

**Monotone** is a Modern Mobile Application, integrated with powerful [Unsplash API](https://unsplash.com/developers) provided by [Unsplash](https://unsplash.com). It implemented almost all features including viewing, searching, collecting photos. And other features, such as profile, license, FAQ are supported as well.

This is an **un-official** application, exploring the feasibility of some conceptions is the goal of this project.
Written in Swift, triggered by RxSwift, draw responsive constraints using SnapKit.

If you like this project or inspired by any ideas of this project, please star it without any hesitation. (ヽ(✿ﾟ▽ﾟ)ノ)

<br/>
<br/>

## Table of Contents
<ol>
    <li><a href="#overview">Overview</a></li>
    <li>
      <a href="#development-progress">Development Progress</a>
      <ul>
        <li><a href="#features">Features</a></li>
        <li><a href="#tasks">Tasks</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#dependencies">Dependencies</a></li>
    <li><a href="#sturcture">Sturcture</a></li>
    <li><a href="#design">Design</a></li>
    <li><a href="#about-unsplash">About Unsplash</a></li>
    <li>
      <a href="#contributing">Contributing</a>
      <ul>
        <li><a href="#how-to-participate-in">How to Participate in</a></li>
      </ul>
    </li>
    <li><a href="#contact-on-me">Contact on Me</a></li>
    <li><a href="#license">License</a></li>
  </ol>

<br/>
<br/>

## Overview

<p align="center"> 
<img width="200" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/screen-record-1.gif">
<img width="200" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/screen-record-2.gif">
</p>

<p align="center"> 
<img width="200" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/screen-shot-1.png">
<img width="200" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/screen-shot-2.png">
<img width="200" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/screen-shot-3.png">
<img width="200" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/screen-shot-4.png">
<img width="200" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/screen-shot-5.png">
<img width="200" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/screen-shot-6.png">
<img width="200" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/screen-shot-7.png">
<img width="200" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/screens_en/screen-shot-8.png">
</p>

<br/>
<br/>

## Development Progress

### Features
- [x] Write Interfaces Programmatically
- [x] Dark Mode Support
- [x] Animation Effects
- [x] Localization
- [x] Powered by [Unsplash API](https://unsplash.com/developers)
- [X] More...

### Tasks
Currently supported tasks:

<table align="center">
    <tr>
        <th style="text-align:center">Position</th>
        <th style="text-align:center">Module</th>
        <th style="text-align:center">Page</th>
        <th style="text-align:center">Style & Layout</th>
        <th style="text-align:center">Powered by Data</th>
        <th style="text-align:center">Animation Effects</th>
        <th style="text-align:center">Localization</th>
    </tr>
    <tr >
        <td align="center" rowspan="7">Main</td>
        <td align="center" rowspan="1">Login</td>
        <td align="center">Sign Up & Sign In</td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center" rowspan="6">Photo</td>
        <td align="center">List (Search & Topic)</td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center">View</td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center">Camera Settings</td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center">Collect (Add & Remove) </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center">Share to SNS</td>
        <td align="center">✅ </td>
        <td align="center">⬜️ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center">Save to Album</td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr >
        <td align="center" rowspan="6">Side Menu</td>
        <td align="center" rowspan="1">Profile</td>
        <td align="center">Details</td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center" rowspan="5">Menu</td>
        <td align="center">My Photos</td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center">Hiring</td>
        <td align="center">✅ </td>
        <td align="center">⬜️ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center">Licenses</td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center">Help</td>
        <td align="center">✅ </td>
        <td align="center">⬜️ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center">Made with Unsplash</td>
        <td align="center">✅ </td>
        <td align="center">⬜️ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr >
        <td align="center" rowspan="5">Tab Bar</td>
        <td align="center" rowspan="2">Store</td>
        <td align="center">Home</td>
        <td align="center">✅ </td>
        <td align="center">⬜️ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
        <tr>
        <td align="center">Details</td>
        <td align="center">✅ </td>
        <td align="center">⬜️ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center" rowspan="1">Wallpaper</td>
        <td align="center">List (Adapt Screen Size)</td>
        <td align="center">✅ </td>
        <td align="center">⬜️ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center" rowspan="1">Collection</td>
        <td align="center">List</td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
    <tr>
        <td align="center" rowspan="1">Explore</td>
        <td align="center">List (Photo & Collection)</td>
        <td align="center">✅ </td>
        <td align="center">⬜️ </td>
        <td align="center">✅ </td>
        <td align="center">✅ </td>
    </tr>
</table>

<br/>
<br/>

## Getting Started
This application uses `Cocoapods` to manage dependencies.
Please refer to [Cocoapods Offical Website](https://cocoapods.org/) to install & configure(If you already installed `Cocoapods`, skip this).

### Prerequisites
**Monotone** is trigged by [Unsplash API](https://unsplash.com/developers) . The very first thing must be done is applying a pair of OAuth key to run it.
1. Visit [Unsplash](https://unsplash.com), sign up then sign in.(If you already have an account, skip this).
2. Visit [Unsplash Application Registration Platform](https://unsplash.com/oauth/applications/new) agree with terms and create a new application, the application name and description can be anything.
3. After the application was created，it will redirect to the application details page automatically (Also can be found from <https://unsplash.com/oauth/applications>). At `Redirect URI & Permissions - Redirect URI` section, input `monotone://unsplash`, make sure all authentication options are checked, just like the image shown below.

<p align="center">
<img width="500" src="https://neko3000-resource-storage.oss-cn-beijing.aliyuncs.com/resource-storage/projects/monotone/app-redirect.png">
</p>

4. After the work is finished, check ”Access Key“ and ”Secret Key“ on this page, they will be used soon.

<br/>

### Installation

1. Execute the following commands in the terminal:
``` bash
# Clone to a local folder
git clone https://github.com/Neko3000/Monotone.git

# Direct to Project folder
cd Monotone

# Install Pods
pod install
```

2. Under **Monotone** folder, duplicate `config_debug.json` file，and rename it to `config.json`(This file is ignored by .gitignore)；
3. Open `config.json` ，input your ”Access Key“ and ”Secret Key“，they will be copyed to APP folder when running.(For more information, please refer to the content in *Project->Build Phases->Run Script* and *APPCredential.swift* )；
4. Done，<kbd>command</kbd> + <kbd>R</kbd>。

<br/>
<br/>

## Dependencies
<table>
    <tr>
        <th>Project</th>
        <th>Description</th>
    </tr>
    <tr >
        <td>RxSwift</td>
        <td>Framework for Reactive Async Programming.</td>
    </tr>
    <tr>
        <td>Action</td>
        <td>Based on RxSwift，encapsulate actions for calling。</td>
    </tr>
    <tr>
        <td>DataSources</td>
        <td>Based on RxSwift，extend logic interaction of tableview and collectionview。</td>
    </tr>
    <tr>
        <td>Alamofire</td>
        <td>HTTP network library.</td>
    </tr>
    <tr>
        <td>SwiftyJSON</td>
        <td>Handle JSON format data effectively.</td>
    </tr>
    <tr>
        <td>ObjectMapper</td>
        <td>Map data between models and JSON.</td>
    </tr>
    <tr>
        <td>Kingfisher</td>
        <td>Network image cache libray with many functions.</td>
    </tr>
    <tr>
        <td>SnapKit</td>
        <td>Make constraints effectively.</td>
    </tr>
    <tr>
        <td>...</td>
        <td>...</td>
    </tr>
</table>

For more information，please check [Podfile](https://github.com/Neko3000/Monotone/blob/master/Podfile)。

<br/>
<br/>

## Project Structure
The basic structure of this project.

```
Monotone 
├── Monotone
│   ├── /Vars  #Global Variables
│   ├── /Enums  #Enums (Includes some dummy data)
│   ├── /Application
│   │   ├── AppCredential  #Authentication Credential
│   │   ...
│   │   └── UserManager  #User Managment
│   ├── /Utils  #Utils
│   │   ├── /BlurHash  #Photo Hash
│   │   ├── ColorPalette  #Global Colors
│   │   ├── AnimatorTrigger  #Animation Effects
│   │   └── MessageCenter  #Message Notification
│   │── /Extension  #Extensions
│   │── /Services  #Services
│   │   ├── /Authentication  #Requests of Authentication
│   │   └── /Network  #Requesets of Data
│   │── /Components  #View Classes
│   │── /ViewModels  #View Models
│   │── /ViewControllers  #View Controllers
│   │── /Models  #Data Models
│   │── /Coordinators  #Segues
│   └── /Resource  #Resource
└── Pods

```

<br/>
<br/>

## Designing
The interface you are seeing are all designed by [Addie Design Co](https://dribbble.com/addiedesign). They shared this [document](https://dribbble.com/shots/7232794-Unsplash-iOS-UI-Kit-Sketch-Invision-Studio), everyone can free download it and use it. Those design elements and their level of completion are astonishing. 
This application would not be here without this design document.

Thanks again to [Addie Design Co](https://dribbble.com/addiedesign) and this beautiful design document.

<br/>
<br/>

## About Unsplash
[Unsplash](https://unsplash.com) is a website dedicated to sharing high-quality stock photography under the Unsplash license. All photos uploaded by photographers will be organized and archived by editors.

And this website is one of my favorites, admired for its artistic, the spirit of sharing.  
You will find my home page here. (~~Not updated frequently since 2020~~)

<br/>
<br/>

## Contributing
Limited by data [Unsplash API](https://unsplash.com/developers) provides, some parts of this application only finished their styles and layouts(Almost in store, explore, etc). If the API provides more detailed data on these parts in the future, we will add new features as soon as possible.

Meanwhile, focusing on the current application, we will improve it continuously.

### How to Participate in
If you are an experienced mobile application developer and want to improve this application. You are welcomed to participate in this open-source project. Practice your ideas, improve even refactor this application.

Follow standard steps:

1. `Fork` this repo;
2. Create your new `Branch` (`git checkout -b feature/AmazingFeature`);
3. Add `Commit` (`git commit -m 'Add some AmazingFeature'`);
4. `Push` to remote `Branch` (`git push origin feature/AmazingFeature`);
5. Open a `Pull Request`.

*For anyone, open an issue if you find any problems. PRs are welcome.*

<br/>
<br/>

## Contact on Me
E-mail: sheran_chen@outlook.com  
Blog: [chienerrant.com](https://chienerrant.com)  
Weibo: [@一只妖艳的绀色布](https://weibo.com/u/7386133210)

<br/>
<br/>

## License
Distributed under the MIT License.  
See [LICENSE](https://github.com/Neko3000/Monotone/blob/master/LICENSE) for more information.

<br/>
<br/>


