
# Packages laden – falls nicht installiert, wird automatisch installiert
load_or_install <- function(package){
  if (!require(package, character.only = TRUE)) {
    install.packages(package, dependencies = TRUE)
    require(package, character.only = TRUE)
  }
}

# Benötigte Packages laden
load_or_install("tidyverse")  # Für Datenverarbeitung und -visualisierung
load_or_install("readxl")     # Zum Einlesen von Excel-Dateien (.xlsx)
load_or_install("haven")      # Zum Exportieren in SPSS-Format (.sav)

# Ordnerpfad zu den Daten definieren
folder_data <- "./data"  # → ggf. Pfad anpassen

# Prüfen, ob der Datenordner existiert
if (!dir.exists(folder_data)) {
  stop("Ordner existiert nicht: ", folder_data)
}

# Liste aller Excel-Dateien im Datenordner erstellen
file_list <- list.files(path = folder_data, pattern = "\\.xlsx$", full.names = TRUE)

# Alle Excel-Dateien in eine Liste laden
data_list <- lapply(file_list, read_excel)

# Beispiel: Eine einzelne Teilnehmerdatei ansehen
# data_1 <- data_list[[1]]
# view(data_1)

# Alle Teilnehmerdaten zu einem Dataframe kombinieren
df_combined <- do.call(rbind, data_list)

# Optional: Spaltenname umbenennen (z.B. bei doppelter Verwendung)
df_combined <- df_combined %>% rename(Subtopic_Nr_2 = "Subtopic_Nr")

# Optional: Nur bestimmte Spalten auswählen (hier auskommentiert)
# df_combined <- df_combined[c("GeneralDomain", "key_resp_Trial.corr", "calibrationScore", "participant")]

# Beispiel: Mittelwert pro "Domain" pro (Participant) "Code" berechnen
#df_summary <- df_combined %>%
#  group_by(Code, Domain) %>%
#  summarize(mean_corr = mean(key_resp_Trial.corr, na.rm = TRUE)) %>%
#  ungroup()


# Kombinierte Datei im SPSS-Format speichern
haven::write_sav(df_combined, path = "./df_combined.sav")


setwd('/Users/paulsedlmayr/Downloads/Combine_participants_script')

df_combined <- read_sav('df_combined.sav')

important_variables <- c("Code", "Gruppe", "Congruency", "Naive_True", "Scientific_True", "JOC", "key_resp_Trial.corr", "calibrationScore", "judgement.resp")
df_combined <- df_combined[, c(important_variables, setdiff(names(df_combined), important_variables))]

haven::write_sav(df_combined, path = "./df_combined.sav")


df_combined <- df_combined %>% select(-all_of(na_cols))

