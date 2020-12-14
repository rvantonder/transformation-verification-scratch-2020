#!/bin/bash

# https://sourcegraph.com/search?q=repo:%5Egithub%5C.com/aws/amazon-freertos%24%40master+file:%5Elibraries+content:%22+assert%28%22&patternType=literal&case=yes
# IFDEFS alises of asserts:
#  IotSerializer_Assert
#  IotMqtt_Assert
#  IotTaskPool_Assert
#  IotContainers_Assert
#  IotBle_Assert
#  AwsIotShadow_Assert
#
# There are 296 of these in C files, don't touch the H ones with defines: 
# https://sourcegraph.com/search?q=repo:%5Egithub%5C.com/aws/amazon-freertos%24%40master+file:%5Elibraries+_Assert+file:%5C.c%24+count:1000&patternType=regexp&case=yes
# this is exactly the matches for comby's 
# comby ':[i~\s+]:[v~\w+_Assert](:[cond]);' ':[i]:[v](:[cond]);:[i]__CPROVER_assume(:[cond]);' .c -stats

DIRS="
ARP/ARPAgeCache
ARP/ARPGetCacheEntry/ARPGetCacheEntry__config_ARPGetCacheEntry_LLMNR
ARP/ARPGetCacheEntry/ARPGetCacheEntry__config_ARPGetCacheEntry_REMOTE_LLMNR
ARP/ARPGetCacheEntry/ARPGetCacheEntry__config_ARPGetCacheEntry_STORE_REMOTE
ARP/ARPGetCacheEntry/ARPGetCacheEntry__config_ARPGetCacheEntry_default
ARP/ARPProcessPacket/ARPProcessPacket__config_disableClashDetection
ARP/ARPProcessPacket/ARPProcessPacket__config_enableClashDetection
ARP/ARPSendGratuitous
ARP/ARP_FreeRTOS_OutputARPRequest/OutputARPRequest__config_CBMC_PROOF_ASSUMPTION_DOES_NOT_HOLD
ARP/ARP_FreeRTOS_OutputARPRequest/OutputARPRequest__config_CBMC_PROOF_ASSUMPTION_HOLDS_Packet_bytes
ARP/ARP_FreeRTOS_OutputARPRequest/OutputARPRequest__config_CBMC_PROOF_ASSUMPTION_HOLDS_no_packet_bytes
ARP/ARP_OutputARPRequest_buffer_alloc1/OutputARPRequest__config_minimal_configuration
ARP/ARP_OutputARPRequest_buffer_alloc1/OutputARPRequest__config_minimal_configuration_linked_rx_messages
ARP/ARP_OutputARPRequest_buffer_alloc1/OutputARPRequest__config_minimal_configuration_minimal_packet_size
ARP/ARPGenerateRequestPacket
ARP/ARPGetCacheEntryByMac
ARP/ARPRefreshCacheEntry/ARPRefreshCacheEntry__config_NOT_STORE_REMOTE
ARP/ARPRefreshCacheEntry/ARPRefreshCacheEntry__config_STORE_REMOTE
ARP/ARP_FreeRTOS_ClearARP
ARP/ARP_FreeRTOS_PrintARPCache
ARP/ARP_OutputARPRequest_buffer_alloc2/OutputARPRequest__config_minimal_configuration
ARP/ARP_OutputARPRequest_buffer_alloc2/OutputARPRequest__config_minimal_configuration_linked_rx_messages
ARP/ARP_OutputARPRequest_buffer_alloc2/OutputARPRequest__config_minimal_configuration_minimal_packet_size
CLI/FreeRTOS_CLIGetParameter
CLI/FreeRTOS_CLIProcessCommand
DHCP/DHCPProcess
DHCP/IsDHCPSocket
CheckOptions
CheckOptionsInner
CheckOptionsOuter
DNS/DNSHandlePacket
DNS/DNSclear
DNS/DNSgetHostByName
DNS/DNSgetHostByName_a
DNS/DNSgetHostByName_cancel
DNS/DNSlookup
IP/SendEventToIPTask 
OTA/prvRequestJob_MQTT
ParseDNSReply
ProcessDHCPReplies
Queue/QueueCreateCountingSemaphore
Queue/QueueCreateCountingSemaphoreStatic
Queue/QueueCreateMutex
Queue/QueueCreateMutexStatic
Queue/QueueGenericCreate/QueueGenericCreate__config_QueueGenericCreate_default
Queue/QueueGenericCreate/QueueGenericCreate__config_QueueGenericCreate_noMutex
Queue/QueueGenericCreate/QueueGenericCreate__config_QueueGenericCreate_noSTATIC_ALLOCATION
Queue/QueueGenericCreate/QueueGenericCreate__config_QueueGenericCreate_useQueueSets
Queue/QueueGenericCreateStatic/QueueGenericCreateStatic__config_QeueuGenericCreateStatic_DynamicAllocation
Queue/QueueGenericCreateStatic/QueueGenericCreateStatic__config_QeueuGenericCreateStatic_NoDynamicAllocation
Queue/QueueGenericReset
Queue/QueueGenericSend/QueueGenericSend__config_QueueGenericSend_QueueSets
Queue/QueueGenericSend/QueueGenericSend__config_QueueGenericSend_noQueueSets
Queue/QueueGenericSendFromISR/QueueGenericSendFromISR__config_QueueGenericSendFromISR_QueueSets
Queue/QueueGenericSendFromISR/QueueGenericSendFromISR__config_QueueGenericSendFromISR_noQueueSets
Queue/QueueGetMutexHolder
Queue/QueueGetMutexHolderFromISR
Queue/QueueGiveFromISR/QueueGiveFromISR__config_QueueGiveFromISR_QueueSets
Queue/QueueGiveFromISR/QueueGiveFromISR__config_QueueGiveFromISR_default
Queue/QueueGiveMutexRecursive
Queue/QueueMessagesWaiting
Queue/QueuePeek
Queue/QueueReceive
Queue/QueueReceiveFromISR
Queue/QueueSemaphoreTake
Queue/QueueSpacesAvailable
Queue/QueueTakeMutexRecursive
Queue/prvCopyDataToQueue/prvCopyDataToQueue__config_prvCopyDataToQueue_default
Queue/prvCopyDataToQueue/prvCopyDataToQueue__config_prvCopyDataToQueue_noMutex
Queue/prvNotifyQueueSetContainer/prvNotifyQueueSetContainer__config_prvNotifyQueueSetContainer_Mutex
Queue/prvNotifyQueueSetContainer/prvNotifyQueueSetContainer__config_prvNotifyQueueSetContainer_noMutex
Queue/prvUnlockQueue/prvUnlockQueue__config_prvUnlockQueue_QueueSets
Queue/prvUnlockQueue/prvUnlockQueue__config_prvUnlockQueue_noQueueSets
ReadNameField
SkipNameField
TCP/prvTCPHandleState
TCP/prvTCPPrepareSend
TCP/prvTCPReturnPacket
TaskPool/TaskCheckForTimeOut
TaskPool/TaskCreate
TaskPool/TaskDelay/TaskDelay__config_default
TaskPool/TaskDelay/TaskDelay__config_vTaskSuspend0
TaskPool/TaskDelete
TaskPool/TaskGetCurrentTaskHandle
TaskPool/TaskGetSchedulerState
TaskPool/TaskGetTaskNumber
TaskPool/TaskGetTickCount
TaskPool/TaskIncrementTick/TaskIncrementTick__config_default
TaskPool/TaskIncrementTick/TaskIncrementTick__config_useTickHook1
TaskPool/TaskPrioritySet
TaskPool/TaskResumeAll/TaskResumeAll__config_default
TaskPool/TaskResumeAll/TaskResumeAll__config_useTickHook1
TaskPool/TaskSetTimeOutState
TaskPool/TaskStartScheduler
TaskPool/TaskSuspendAll
TaskPool/TaskSwitchContext
parsing/ProcessIPPacket
parsing/ProcessReceivedTCPPacket
parsing/ProcessReceivedUDPPacket
"

for D in $DIRS; do
    echo "[+] Doing $D"
    make -C $D &> /dev/null # warmup
    make -C clean &> /dev/null # clean
    { time make -C $D &> /dev/null ; } 2> ./$D/time-vanilla.txt
    echo "[+] Time vanilla:" 
    cat ./$D/time-vanilla.txt | head -n 2 | tail -n 1
    cp $D/{cbmc.txt,cbmc-vanilla.txt}
    make -C clean &> /dev/null # clean
    echo "[+] Vanilla done for $D"

    # Patch
    echo "Patching asserts in 'libraries' with comby..."

    cd ../../../libraries
    comby ':[i~\s+]assert(:[cond]);' ':[i]assert(:[cond]);:[i]__CPROVER_assume(:[cond]);' .c -stats -i &> /dev/null
    comby ':[i~\s+]:[v~\w+_Assert](:[cond]);' ':[i]:[v](:[cond]);:[i]__CPROVER_assume(:[cond]);' .c -stats -i &> /dev/null
    cd ../tools/cbmc/proofs

    # Run on comby state
    make -C $D &> /dev/null # warmup
    make -C clean &> /dev/null # clean
    { time make -C $D &> /dev/null ; } 2> ./$D/time-comby.txt
    echo "[+] Time comby:" 
    cat ./$D/time-comby.txt | head -n 2 | tail -n 1
    cp $D/{cbmc.txt,cbmc-comby.txt}
    make -C clean &> /dev/null # clean
    echo "[+] Comby done for $D"

    # Restore files
    cd ../../../libraries
	git restore \*

    cd 3rdparty/lwip
	git restore \*
    cd ../..

    cd abstractions/backoff_algorithm
    git restore \*
    cd ../..

    cd coreHTTP
    git restore \*
    cd source/dependency/3rdparty/http_parser
    git restore \*
    cd ../../../../../

    cd coreJSON
    git restore \*
    cd ..

    cd coreMQTT
	git restore \*
    cd ..
    
	cd device_defender_for_aws	
	git restore \*
	cd ..

	cd jobs_for_aws
	git restore \*
	cd ..

	cd ../tools/cbmc/proofs
    echo "[+] Restored files"
    echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-"
	echo
done



