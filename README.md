# 一个简单的ios/mac上播放 amr 例子

## 概述
内部使用 openamr 库来进行转码播放。

## 接口

```Objective-C
//#import <IosAmrAudioCache.h>
// 创建一个 audioCache
IosAudioCache* cache = [[IosAudioCache alloc] init];
// 播放一个文件或预加载一个文件来获得 音频的id
int audioId = [cache preloadAudio:@"test.amr"]; // 预加载一个音频文件
int audioId = [cache playAudio:@"test.amr"];   // 播放一个音频文件
// 有了音频id， 可以执行获取音频长度，设置音频偏移，暂停恢复等操作
[cache pauseAudio:audioId];  // 暂停
[cache resumeAudio:audioId]; // 恢复
[cache unloadAudio:audioId];// 卸载
[cache stopAudio:audioId];// 停止
double offset = [cache getAudioTime:audioId]; // 获取当前播放时间
[cache seekAudio:audioId toTime:2]; // 音频跳转到2秒处
// 卸载所有音频
[cache unloadAllAudios];
```

## C++ 接口

```C++
// #include "CppIosAmrAudioCache.h"
// 创建一个 audioCache, 可以使用 sharedCache() 获取一个内置的全局实例
CppICppIosAmrAudioCache* cache = CppIosAmrAudioCache::sharedCache();
// 播放一个文件或预加载一个文件来获得 音频的id
int audioId = cache->preloadAudio("test.amr"); // 预加载一个音频文件
int audioId = cache->playAudio("test.amr");   // 播放一个音频文件
// 有了音频id， 可以执行获取音频长度，设置音频偏移，暂停恢复等操作
cache->pauseAudio(audioId);  // 暂停
cache->resumeAudio(audioId); // 恢复
cache->unloadAudio(audioId);// 卸载
cache->stopAudio(audioId);// 停止
double offset = cache->getAudioTime(audioId); // 获取当前播放时间
cache->seekAudioToTime(audioId, 2); // 音频跳转到2秒处
// 卸载所有音频
cache->unloadAllAudios()
```




