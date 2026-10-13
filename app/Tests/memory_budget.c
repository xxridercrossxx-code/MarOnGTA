#include "NativeMemoryBudget.h"
#include <assert.h>
#include <stdio.h>
int main(void){
 assert(pg_streaming_headroom_budget(1000,2000,384)==1000);
 assert(pg_streaming_headroom_budget(1000,600,384)==216);
 assert(pg_streaming_headroom_budget(1000,384,384)==0);
 assert(pg_streaming_headroom_budget(1000,0,384)==0);
 assert(pg_streaming_headroom_budget(0,1000,384)==0);
 assert(pg_streaming_headroom_budget(UINT64_MAX,UINT64_MAX,384)==UINT64_MAX-384);
 assert(pg_streaming_resource_budget(1000,2000,384)==1000);
 assert(pg_streaming_resource_budget(1000,600,384)==216);
 assert(pg_streaming_resource_budget(1000,384,384)==0);
 assert(pg_streaming_resource_budget(1000,100,384)==-284);
 assert(pg_streaming_resource_budget(1000,0,384)==-384);
 assert(pg_streaming_resource_budget(-1000,100,384)==-1000);
 assert(pg_streaming_resource_budget(0,100,384)==-284);
 assert(pg_streaming_resource_budget(INT64_MAX,UINT64_MAX,384)==INT64_MAX);
 assert(pg_streaming_resource_budget(INT64_MAX,0,UINT64_MAX)==INT64_MIN);
 assert(pg_streaming_resource_budget(INT64_MIN,UINT64_MAX,384)==INT64_MIN);
 puts("PASS: native streaming reserve, unsigned heap clamp, signed eviction deficit, original deficit preservation and overflow boundaries.");
}
