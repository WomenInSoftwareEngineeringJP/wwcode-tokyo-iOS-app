package com.womenwhocode.tokyo.event

import com.nhaarman.mockitokotlin2.doReturn
import com.nhaarman.mockitokotlin2.mock
import com.womenwhocode.tokyo.event.RepositoryEvent.Location
import com.womenwhocode.tokyo.meetupapi.EventType.PAST
import com.womenwhocode.tokyo.meetupapi.EventType.UPCOMING
import com.womenwhocode.tokyo.meetupapi.MeetupAPIClient
import com.womenwhocode.tokyo.meetupapi.MeetupAPIEvent
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test

class MeetupEventRepositoryInPersonEventTest {
    private lateinit var subject: MeetupEventRepository
    private lateinit var APIClient: MeetupAPIClient

    @BeforeEach
    internal fun setUp() {
        val meetupVenue = MeetupAPIEvent.MeetupAPIEventVenue(
            "venueName",
            1.23,
            4.56,
            "address_1",
            "city"
        )

        val upcomingMeetupEvent = MeetupAPIEvent(
            "1",
            7200000,
            "eventName",
            "local_date",
            "local_time",
            1,
            2,
            meetupVenue,
            "upcoming-event-link",
            "description"
        )

        val pastMeetupEvent = MeetupAPIEvent(
            "2",
            10800000,
            "Strawberry Festival",
            "2020-02-15",
            "10:00",
            10,
            99,
            meetupVenue,
            "past-event-link",
            "Yokohama"
        )

        APIClient = mock {
            on { getEvents(true, "public", "upcoming", false, "2019-06-01T00:00:00.000", 30) } doReturn listOf(
                upcomingMeetupEvent
            )
            on { getEvents(true, "public", "past", true, "2019-06-01T00:00:00.000", 30) } doReturn listOf(
                pastMeetupEvent
            )
        }

        subject = MeetupEventRepository(APIClient)
    }

    @Test
    fun `returns upcoming events from meetup api if status is upcoming`() {
        val response = subject.getEvents(UPCOMING)

        val event = response.first()
        assertThat(event.id, equalTo("1"))
        assertThat(event.name, equalTo("eventName"))
        assertThat(event.date, equalTo("local_date"))
        assertThat(event.duration, equalTo(7200000))
        assertThat(event.time, equalTo("local_time"))
        assertThat(event.link, equalTo("upcoming-event-link"))
        assertThat(event.venue?.name, equalTo("venueName"))
        assertThat(event.venue?.location, equalTo(Location(1.23, 4.56, "address_1", "city")))
    }

    @Test
    fun `returns past events from meetup api if status is past`() {
        val response = subject.getEvents(PAST)

        val event = response.first()
        assertThat(event.id, equalTo("2"))
        assertThat(event.name, equalTo("Strawberry Festival"))
        assertThat(event.date, equalTo("2020-02-15"))
        assertThat(event.duration, equalTo(10800000))
        assertThat(event.time, equalTo("10:00"))
        assertThat(event.link, equalTo("past-event-link"))
        assertThat(event.venue?.name, equalTo("venueName"))
        assertThat(event.venue?.location, equalTo(Location(1.23, 4.56, "address_1", "city")))
    }
}
