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
                "name",
                1.23,
                4.56,
                "address_1",
                "city")

        val meetupEvent = MeetupEvent(
                "name",
                "local_date",
                "local_time",
                1,
                2,
                meetupVenue,
                "link",
                "description")

        client = mock {
            on { getEvents(true, "public", "recent_past", 20) } doReturn listOf(meetupEvent)
        }

        subject = MeetupEventRepository(client)
    }

    @Test
    fun `get events returns events from meetup`() {
        val response = subject.getEvents()

        assertThat(response[0].name, equalTo("name"))
    }
}
