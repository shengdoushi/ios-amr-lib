//
//  CppIosAmrAudioCache.h
//  iosamrsupport
//
//  Created by guolihui on 14-10-17.
//  Copyright (c) 2014年 shengdoushi. All rights reserved.
//
#pragma  once

#include <string>

class CppIosAmrAudioCacheImpl;

class CppIosAmrAudioCache
{
public:
    CppIosAmrAudioCache();
    ~CppIosAmrAudioCache();
    
    static CppIosAmrAudioCache* sharedCache();
    
    int playAudio(const std::string& strPath);
    void pauseAudio(int audioId);
    void resumeAudio(int audioId);
    void stopAudio(int audioId);
    int preloadAudio(const std::string& strPath);
    void unloadAudio(int audioId);
    
    void unloadAllAudios();
    double getAudioDuration(int audioId);
    
    // 获取当前播放时长
    double getAudioTime(int audioId);
private:
    CppIosAmrAudioCacheImpl* m_impl;
};