import matplotlib.pyplot as plt

def extraer_temperaturas(nombre_archivo):
    with open(nombre_archivo) as f:
        lineas = f.readlines()
    temperaturas = []
    for linea in lineas:
        if "T =" in linea:
            try:
                temp_str = linea.split("T =")[1].split("->")[0].strip()
                temperatura = float(temp_str)
                temperaturas.append(temperatura)
            except ValueError:
                continue
    return temperaturas

# Extraer datos
temp_100 = extraer_temperaturas("datos_temperatura_100.txt")
temp_200 = extraer_temperaturas("datos_temperatura_200.txt")

# Crear ejes de tiempo
tiempo_100 = list(range(len(temp_100)))
tiempo_200 = list(range(len(temp_200)))

# Graficar
plt.plot(tiempo_100, temp_100, color='blue', label='Tref = 100 °C')
plt.plot(tiempo_200, temp_200, color='red', label='Tref = 200 °C')

plt.title("Comparación de evolución de temperatura del horno")
plt.xlabel("Tiempo (s)")
plt.ylabel("Temperatura (°C)")
plt.grid(True)
plt.legend()
plt.tight_layout()
plt.show()
