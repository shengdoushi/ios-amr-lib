//
//  CppIosAmrAudioCache.cpp
//  iosamrsupport
//
//  Created by guolihui on 14-10-17.
//  Copyright (c) 2014年 shengdoushi. All rights reserved.
//

#import "CppIosAmrAudioCache.h"
#import "IosAmrAudioCache.h"

static int __gh_static_cache_max_id = 0;
static NSMutableDictionary __strong * __gh_static_cache_cache = [[NSMutableDictionary alloc] init];

class CppIosAmrAudioCacheImpl
{
public:
    CppIosAmrAudioCacheImpl()
    {
        m_objcCache = [[IosAudioCache alloc] init];
        m_cacheId = __gh_static_cache_max_id + 1;
        __gh_static_cache_max_id++;
        [__gh_static_cache_cache setValue:m_objcCache forKey:[NSString stringWithFormat:@"%d", m_cacheId]];
    }
    
    ~CppIosAmrAudioCacheImpl()
    {
        [__gh_static_cache_cache removeObjectForKey:[NSString stringWithFormat:@"%d", m_cacheId]];
    }
    IosAudioCache* m_objcCache;
private:
    int m_cacheId;
};

CppIosAmrAudioCache* CppIosAmrAudioCache::sharedCache()
{
    static CppIosAmrAudioCache cache;
    return &cache;
}

CppIosAmrAudioCache::CppIosAmrAudioCache()
{
    m_impl = new CppIosAmrAudioCacheImpl;
}

CppIosAmrAudioCache::~CppIosAmrAudioCache()
{
    delete m_impl;
}

int CppIosAmrAudioCache::playAudio(const std::string &strPath)
{
    return [m_impl->m_objcCache playAudio:[NSString stringWithUTF8String:strPath.c_str()]];
}

void CppIosAmrAudioCache::pauseAudio(int audioId)
{
    [m_impl->m_objcCache pauseAudio:audioId];
}

void CppIosAmrAudioCache::resumeAudio(int audioId)
{
    [m_impl->m_objcCache resumeAudio:audioId];
}

void CppIosAmrAudioCache::stopAudio(int audioId)
{
    [m_impl->m_objcCache stopAudio:audioId];
}

int CppIosAmrAudioCache::preloadAudio(const std::string &strPath)
{
    return [m_impl->m_objcCache preloadAudio:[NSString stringWithUTF8String:strPath.c_str()]];
}

double CppIosAmrAudioCache::getAudioDuration(int audioId)
{
    return [m_impl->m_objcCache getAudioDuration:audioId];
}

double CppIosAmrAudioCache::getAudioTime(int audioId)
{
    return [m_impl->m_objcCache getAudioTime:audioId];
}
void CppIosAmrAudioCache::unloadAllAudios()
{
    [m_impl->m_objcCache unloadAllAudios];
}

void CppIosAmrAudioCache::unloadAudio(int audioId)
{
    [m_impl->m_objcCache unloadAudio:audioId];
}
