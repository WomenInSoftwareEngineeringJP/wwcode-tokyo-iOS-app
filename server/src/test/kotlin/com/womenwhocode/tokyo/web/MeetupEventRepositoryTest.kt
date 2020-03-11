package com.womenwhocode.tokyo.web

import com.nhaarman.mockitokotlin2.doReturn
import com.nhaarman.mockitokotlin2.mock
import org.hamcrest.CoreMatchers.equalTo
import org.hamcrest.MatcherAssert.assertThat
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.Test


internal class MeetupEventRepositoryTest {

    private lateinit var subject: MeetupEventRepository
    private lateinit var client: MeetupClient

    @BeforeEach
    internal fun setUp() {
        val meetupVenue = MeetupEvent.MeetupVenue(
                "venueName",
                1.23,
                4.56,
                "address_1",
                "city")

        val upcomingMeetupEvent = MeetupEvent(
                7200000,
                "eventName",
                "local_date",
                "local_time",
                1,
                2,
                meetupVenue,
                "link",
                "description")

        client = mock {
            on { getEvents(true, "public", "upcoming", "2019-06-01T00:00:00.000",20) } doReturn listOf(upcomingMeetupEvent)
        }

        subject = MeetupEventRepository(client)
    }

    @Test
    fun `get events returns upcoming events from meetup if status is upcoming`() {
        val response = subject.getEvents()

        assertThat(response[0].name, equalTo("eventName"))
        assertThat(response[0].date, equalTo("local_date"))
        assertThat(response[0].duration, equalTo(7200000))
        assertThat(response[0].time, equalTo("local_time"))
        assertThat(response[0].venueName, equalTo("venueName"))
    }

}
