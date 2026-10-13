#pragma once
#include <stdint.h>
// Keep a 256 MiB resource-pool growth step plus transient upload headroom.
// The virtual heap capacity is unchanged; this only informs streaming eviction.
static inline uint64_t pg_streaming_headroom_budget(uint64_t engineAvailable,uint64_t processAvailable,uint64_t reserve){
 uint64_t available=processAvailable>reserve?processAvailable-reserve:0;
 return engineAvailable<available?engineAvailable:available;
}
// The resource budget is signed. Below the reserve, a negative answer asks
// the existing streamer to evict that many bytes; zero only stops growth.
static inline int64_t pg_streaming_resource_budget(int64_t engineAvailable,uint64_t processAvailable,uint64_t reserve){
 int64_t available;
 if(processAvailable>=reserve){
  uint64_t remaining=processAvailable-reserve;
  available=remaining>INT64_MAX?INT64_MAX:(int64_t)remaining;
 }else{
  uint64_t deficit=reserve-processAvailable;
  available=deficit>INT64_MAX?INT64_MIN:-(int64_t)deficit;
 }
 return engineAvailable<available?engineAvailable:available;
}
