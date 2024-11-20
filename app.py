from flask import Flask, render_template, request, redirect, url_for
from flask_mysqldb import MySQL

app = Flask(__name__)

# Infos pour ma bd
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'mysql'
app.config['MYSQL_DB'] = 'pizza'

mysql = MySQL(app)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/ajouter-client')
def ajouter_client():
    return render_template('ajouter-client.html')

@app.route('/add_client', methods=['POST'])
def add_client():
    # Prendre les infos du formulaire pour ensuite les mettres dans la bd
    nom = request.form['nom']
    prenom = request.form['prenom']
    numero_telephone = request.form['numero_telephone']
    adresse = request.form['adresse']

    # Entrer le client dans la bd
    cursor = mysql.connection.cursor()
    cursor.execute('''
        INSERT INTO client (nom, prenom, numero_telephone, adresse)
        VALUES (%s, %s, %s, %s)
    ''', (nom, prenom, numero_telephone, adresse))
    mysql.connection.commit()
    cursor.close()

    return redirect(url_for('index'))

@app.route('/ajouter-commande', methods=['GET', 'POST'])
def ajouter_commande():
    # Chaque requete select toutes les infos des ingredients pour les envoyer a la page de commande
    cursor = mysql.connection.cursor()

    cursor.execute("SELECT id, nom, prenom FROM client")
    clients = cursor.fetchall()

    cursor.execute("SELECT id, titre FROM croute")
    croute_options = cursor.fetchall()

    cursor.execute("SELECT id, titre FROM sauce")
    sauce_options = cursor.fetchall()

    cursor.execute("SELECT id, titre FROM garniture")
    garnitures = cursor.fetchall()

    cursor.close()

    #Si le formulaire est rempli entrer les donnees dans la bd
    if request.method == 'POST':
        client_id = request.form.get('client')
        croute_id = request.form.get('croute')
        sauce_id = request.form.get('sauce')
        garniture1_id = request.form.get('garniture1')
        garniture2_id = request.form.get('garniture2')
        garniture3_id = request.form.get('garniture3')
        garniture4_id = request.form.get('garniture4')

        # Entrer la pizza dans la bd avec le id des ingredients
        cursor = mysql.connection.cursor()
        cursor.execute('''
            INSERT INTO pizza (croute, sauce, garniture1, garniture2, garniture3, garniture4)
            VALUES (%s, %s, %s, %s, %s, %s)
        ''', (croute_id, sauce_id, garniture1_id, garniture2_id, garniture3_id, garniture4_id))
        mysql.connection.commit()
        pizza_id = cursor.lastrowid  # Récupérer l'ID de la pizza insérée
        cursor.close()

        # Entrer la commande dans la bd
        cursor = mysql.connection.cursor()
        cursor.execute('''
            INSERT INTO commande (id_client, id_pizza)
            VALUES (%s, %s)
        ''', (client_id, pizza_id))
        mysql.connection.commit()
        cursor.close()

        return redirect(url_for('index'))

    return render_template('ajouter-commande.html', clients=clients, croute_options=croute_options,
                           sauce_options=sauce_options, garnitures=garnitures)

@app.route('/livrer', methods=['GET', 'POST'])
def livrer():
    # Requete pour recuperer avec des alias les donnees sur une commande, on join client pour avoir son nom, ensuite on dois join sur chaque option de la pizza sinon on a que le id d'example la croute et mettre ca dans commandes.
    cursor = mysql.connection.cursor()
    cursor.execute('''
        SELECT c.id, cl.nom, cl.prenom, p.id, 
               cr.titre AS croute, s.titre AS sauce,
               g1.titre AS garniture1, g2.titre AS garniture2,
               g3.titre AS garniture3, g4.titre AS garniture4
        FROM commande_en_attente c
        JOIN client cl ON c.id_client = cl.id
        JOIN pizza p ON c.id_pizza = p.id
        JOIN croute cr ON p.croute = cr.id
        JOIN sauce s ON p.sauce = s.id
        LEFT JOIN garniture g1 ON p.garniture1 = g1.id
        LEFT JOIN garniture g2 ON p.garniture2 = g2.id
        LEFT JOIN garniture g3 ON p.garniture3 = g3.id
        LEFT JOIN garniture g4 ON p.garniture4 = g4.id
    ''')
    commandes = cursor.fetchall()
    cursor.close()

    if request.method == 'POST':
        # Prendre le id de la commande en question pour ensuite la supprimer
        commande_id = request.form.get('commande_id')

        # Deleter la commande
        cursor = mysql.connection.cursor()
        cursor.execute('DELETE FROM commande_en_attente WHERE id = %s', (commande_id,))
        mysql.connection.commit()
        cursor.close()

        return redirect(url_for('livrer'))

    return render_template('livrer.html', commandes=commandes)


if __name__ == '__main__':
    app.run(debug=True)
