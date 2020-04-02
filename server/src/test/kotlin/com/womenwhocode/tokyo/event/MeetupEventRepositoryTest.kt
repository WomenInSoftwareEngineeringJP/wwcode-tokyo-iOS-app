package com.womenwhocode.tokyo.event

import com.nhaarman.mockitokotlin2.doReturn
import com.nhaarman.mockitokotlin2.mock
import com.womenwhocode.tokyo.meetupapi.EventType.*
import com.womenwhocode.tokyo.meetupapi.MeetupAPIClient
import com.womenwhocode.tokyo.meetupapi.MeetupAPIEvent
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test


internal class MeetupEventRepositoryTest {

    private lateinit var subject: MeetupEventRepository
    private lateinit var APIClient: MeetupAPIClient

    @BeforeEach
    internal fun setUp() {
        val meetupVenue = MeetupAPIEvent.MeetupAPIEventVenue(
                "venueName",
                1.23,
                4.56,
                "address_1",
                "city")

        val upcomingMeetupEvent = MeetupAPIEvent(
                7200000,
                "eventName",
                "local_date",
                "local_time",
                1,
                2,
                meetupVenue,
                "upcoming-event-link",
                "description")

        val pastMeetupEvent = MeetupAPIEvent(
                10800000,
                "Strawberry Festival",
                "2020-02-15",
                "10:00",
                10,
                99,
                meetupVenue,
                "past-event-link",
                "Yokohama")

        APIClient = mock {
            on { getEvents(true, "public", "upcoming", false,"2019-06-01T00:00:00.000",30) } doReturn listOf(upcomingMeetupEvent)
            on { getEvents(true, "public", "past", true, "2019-06-01T00:00:00.000",30) } doReturn listOf(pastMeetupEvent)
        }

        subject = MeetupEventRepository(APIClient)
    }

    @Test
    fun `get events returns upcoming events from meetup if status is upcoming`() {
        val response = subject.getEvents(UPCOMING)

        assertThat(response[0].name, equalTo("eventName"))
        assertThat(response[0].date, equalTo("local_date"))
        assertThat(response[0].duration, equalTo(7200000))
        assertThat(response[0].time, equalTo("local_time"))
        assertThat(response[0].link, equalTo("upcoming-event-link"))
        assertThat(response[0].venue.name, equalTo("venueName"))
        assertThat(response[0].venue.lat, equalTo(1.23))
        assertThat(response[0].venue.lon, equalTo(4.56))
        assertThat(response[0].venue.address, equalTo("address_1"))
        assertThat(response[0].venue.city, equalTo("city"))
    }

    @Test
    fun `get events returns past events from meetup if status is past`() {
        val response = subject.getEvents(PAST)

        assertThat(response[0].name, equalTo("Strawberry Festival"))
        assertThat(response[0].date, equalTo("2020-02-15"))
        assertThat(response[0].duration, equalTo(10800000))
        assertThat(response[0].time, equalTo("10:00"))
        assertThat(response[0].link, equalTo("past-event-link"))
        assertThat(response[0].venue.name, equalTo("venueName"))
        assertThat(response[0].venue.lat, equalTo(1.23))
        assertThat(response[0].venue.lon, equalTo(4.56))
        assertThat(response[0].venue.address, equalTo("address_1"))
        assertThat(response[0].venue.city, equalTo("city"))
    }

}
