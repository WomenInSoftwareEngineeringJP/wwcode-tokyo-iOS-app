package com.womenwhocode.tokyo.web

import org.springframework.stereotype.Service
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.format.DateTimeFormatter

@Service
class EventService(val repo: MeetupEventRepository) {
    fun getEvents(): List<WWCEvent> {
        return repo.getEvents()
                .map {
                    val date = LocalDate.parse(it.date)
                    val formatter = DateTimeFormatter.ofPattern("MMM dd, EEE")
                    val formattedDate = date.format(formatter)

                    // minutes
                    val duration = it.duration / 1000 / 60

                    val dateTime = LocalDateTime.parse("${it.date}T${it.time}:00")
                    val endDateTime = dateTime.plusMinutes(duration.toLong())

                    val endDateFormatter = DateTimeFormatter.ofPattern("kk:mm")
                    val endDate = endDateTime.format(endDateFormatter)

                    val formattedTime = "${it.time} - $endDate"

                    WWCEvent(
                            it.name,
                            formattedDate,
                            formattedTime,
                            it.venueName)
                }
    }
}
