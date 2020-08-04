#[derive(Debug)]
pub struct Duration(f64);
impl From<u64> for Duration {
    fn from(s: u64) -> Self {
        Self(s as f64)
    }
}

pub trait Planet {
    const ORBITAL: f64;
    fn years_during(Duration(d): &Duration) -> f64 {
        let earth_seconds_per_year = (60 * 60 * 24) as f64 * 365.25;
        d / earth_seconds_per_year / Self::ORBITAL
    }
}

pub struct Mercury;
impl Planet for Mercury {
    const ORBITAL: f64 = 0.2408467;
}

pub struct Venus;
impl Planet for Venus {
    const ORBITAL: f64 = 0.61519726;
}
pub struct Earth;
impl Planet for Earth {
    const ORBITAL: f64 = 1.0;
}

pub struct Mars;
impl Planet for Mars {
    const ORBITAL: f64 = 1.8808158;
}

pub struct Jupiter;
impl Planet for Jupiter {
    const ORBITAL: f64 = 11.862615;
}

pub struct Saturn;
impl Planet for Saturn {
    const ORBITAL: f64 = 29.447498;
}

pub struct Uranus;
impl Planet for Uranus {
    const ORBITAL: f64 = 84.016846;
}

pub struct Neptune;
impl Planet for Neptune {
    const ORBITAL: f64 = 164.79132;
}
