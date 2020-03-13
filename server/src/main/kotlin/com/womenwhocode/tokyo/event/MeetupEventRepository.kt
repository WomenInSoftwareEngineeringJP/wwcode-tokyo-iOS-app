package com.womenwhocode.tokyo.event

import com.womenwhocode.tokyo.meetupapi.EventType
import com.womenwhocode.tokyo.meetupapi.MeetupAPIClient
import org.springframework.stereotype.Repository

@Repository
class MeetupEventRepository(val meetupAPIClient: MeetupAPIClient) {
    fun getEvents(status: EventType): List<RepositoryEvent> {
        val meetupEvents = meetupAPIClient.getEvents(
                true,
                "public",
                status.meetupAPIEventTypeCode,
                status == EventType.PAST,
                "2019-06-01T00:00:00.000",
                30)
        return meetupEvents.map { meetupEvent ->
            RepositoryEvent(
                    meetupEvent.name,
                    meetupEvent.local_date,
                    meetupEvent.local_time,
                    meetupEvent.duration,
                    meetupEvent.venue.name
            )
        }
    }
}
