# 🧑‍🔬 HEP Tools in Docker

A ready-to-use environment for **High Energy Physics (HEP)** with:

- Prebuilt Docker image with all HEP tools ready to use.
- Shared workspace between containers for seamless workflow.
- GUI support for ROOT and Geant4 visualizations.
- Enables reproducible and portable teaching and research setups.

Perfect for students starting new projects, running analysis, and documenting work. Atm, it comes with:

- ROOT
- Geant4
- JupyterLab
- Python libraries (NumPy, Pandas, Uproot, Matplotlib, etc.)

---

## 🚀 Quick Start

1. **Start the container**  
   You can run the script ./start.sh and you'll run a docker containers with X11 display.

2. **Open JupyterLab**  
   After the container starts, you will see a link like: http://127.0.0.1:8888/lab?token=XXXX
   
Copy this into your browser.


3. **Work in `/workspace`**  
All your notebooks, code, and data are saved there.  
This folder is mounted to your computer so your files stay safe even after stopping the container.

---

## ✨ What You Can Do

- Write and run **Python or C++ ROOT macros** directly inside Jupyter notebooks  
- Create and customize plots with Matplotlib or ROOT  
- Document your progress with **Markdown + LaTeX**  
- Export your notebook to **PDF or HTML** for reports  

---

## 💡 Why Use This?

- ✅ No complicated setup — everything works out of the box  
- ✅ Same environment for everyone (containerized) → easy to reproduce results  
- ✅ Jupyter notebooks make it easy to organize your work into steps  
- ✅ Great for learning, exploring, and reporting  

---

## 📌 Tip for Students

- Keep one notebook per week (or per task) to track progress.  
- Use Markdown cells to explain your code, and LaTeX for equations.  
- Try exporting to **PDF** (requires TeX, may be slower).  

---
