
# 📡 latvisualiser — WiFi Latency Visualiser

A minimal **Haskell-based terminal latency visualiser** that monitors real-time network latency and renders a live ASCII graph with time and latency axes.
Designed as a lightweight academic networking project combining functional programming with system-level monitoring.

---

## 🚀 Overview

**latvisualiser** is a terminal-first monitoring tool that measures internet latency using periodic ping requests and displays a scrolling mathematical-style graph directly inside the console.

The project focuses on simplicity and clarity, demonstrating how functional programming concepts can be applied to real-time network analysis without external UI frameworks.

---

## ✨ Core Features

* 📶 **Real-Time Latency Monitoring** — Continuous ping-based measurement
* 📊 **ASCII Graph Rendering** — Terminal-based X–Y axis visualisation
* 📈 **Trend Detection** — Identifies stable, increasing, or decreasing latency
* ⚡ **Lightweight Implementation** — Pure Haskell, minimal dependencies
* 🧩 **Educational Design** — Suitable for networking and systems coursework
* 🖥️ **Terminal Native** — No GUI or external visualization libraries

---

## 🏗️ Project Architecture

latvisualiser/
│
├── src/
│ └── latency.hs # Core latency monitoring and graph rendering logic
├── README.md
└── .gitignore


## ⚙️ Technology Stack

| Layer            | Technology |
|------------------|------------|
| Language         | Haskell    |
| Networking       | System ping (ICMP) |
| Rendering        | ASCII Terminal Graphics |
| Concurrency      | Control.Concurrent |
| Parsing          | Text.Read / Data.List |

---

## 🧪 Installation

Clone the repository:

```bash
git clone https://github.com/nijint/latvisualiser.git
cd latvisualiser
runhaskell src/latency.hs
```

## ⚙️ How It Works

* 📡 **Ping Sampling** — Periodically sends ICMP ping requests to a target host (default: `8.8.8.8`) to measure real network latency.
* 🔎 **Latency Extraction** — Parses the system ping output and retrieves response time values in milliseconds.
* 🧠 **Rolling History Buffer** — Stores recent latency samples to create a continuous time-based dataset.
* 📊 **Dynamic Graph Scaling** — Normalizes latency values to fit within a fixed terminal graph height.
* 🖥️ **ASCII Graph Rendering** — Displays a live terminal graph with X–Y axes, statistics, and trend indicators.


## 📐 Graph Output

LATENCY GRAPH  host: 8.8.8.8

120ms |      ███
100ms |    ██████
 80ms |  █████████
 60ms |███████████
     +------------------------------
       time →


## 📊 Metrics Displayed

* Current latency (ms)
* Minimum latency
* Average latency
* Maximum latency

## 📌 Design Goals

Demonstrate functional programming in real-time systems
Provide a minimal networking visualisation tool
Maintain readable, beginner-friendly Haskell code
Avoid heavy UI frameworks

## 🧩 Potential Use Cases

Computer Networks coursework
Functional programming experiments
terminal monitoring tools
Academic visualization projects

## 🔮 Future Enhancements

Unicode line-graph rendering
Color-coded latency thresholds
Packet loss tracking
Configurable refresh intervals
Multi-host comparison mode

## 👨‍💻 Author
@nijint
(Developed as a learning-focused networking and Haskell experimentation project)



