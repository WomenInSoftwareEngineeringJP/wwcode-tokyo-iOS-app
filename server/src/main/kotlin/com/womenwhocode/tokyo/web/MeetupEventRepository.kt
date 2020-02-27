package com.womenwhocode.tokyo.web

class MeetupEventRepository(val meetupClient: MeetupClient) {
    fun getEvents(): List<MeetupEvent> {
        return meetupClient.getEvents(true, "public", "recent_past", 20)
    }

}