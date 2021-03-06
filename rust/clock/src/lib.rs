use std::fmt;

#[derive(Debug, PartialEq)]
pub struct Clock {
    hrs: i32,
    mins: i32,
}

const MINS_PER_HOUR: i32 = 60;
const HOURS_PER_DAY: i32 = 24;
const MINS_PER_DAY: i32 = HOURS_PER_DAY * MINS_PER_HOUR;

impl Clock {
    pub fn new(hours: i32, minutes: i32) -> Self {
        let mins_max_one_day = ((hours * MINS_PER_HOUR) + minutes).rem_euclid(MINS_PER_DAY);

        Clock {
            hrs: mins_max_one_day / MINS_PER_HOUR,
            mins: mins_max_one_day % MINS_PER_HOUR,
        }
    }

    pub fn add_minutes(&self, minutes: i32) -> Self {
        Self::new(self.hrs, self.mins + minutes)
    }
}

impl fmt::Display for Clock {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{:02}:{:02}", self.hrs, self.mins)
    }
}
