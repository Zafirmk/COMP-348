#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Structure of the node containing all car values
struct maker {
    char maker[20];
    char model[20];
    char km[10];
    char type[20];
    char stock[10];
    char driveTrain[10];
    char status[10];
    char fuelEcon[20];
    char year[10];
    char trim[10];
    char transmission[10];
    char features[200];
    struct maker * next;
    struct maker * bottom;
};

//Hash structure for searchInventory file
struct searchHash {
    char key[15];
    char value[20];
};

//Helper method to add2Inventory (Adds into the maker level structures)
void addToList(struct maker * head, struct maker * prev, struct maker * nodeToAdd) {
    //If nothing after head
    if (head -> next == NULL) {
        //Add after head
        head -> next = nodeToAdd;
    } else {
        //Add after the last node
        prev -> next = nodeToAdd;
    }
}

//Helper method to add2Inventory (Adds into the model level structures)
void addToBottom(struct maker * head, struct maker * nodeToInsert) {
    struct maker * curr_node = head;
    //If no bottom node exists
    if (curr_node -> bottom == NULL) {
        //Add to bottom
        curr_node -> bottom = nodeToInsert;
    } else {
        //If a bottom already exists
        curr_node = curr_node -> bottom;
        //If nothing after the bottom head node add
        if (curr_node -> next == NULL) {
            curr_node -> next = nodeToInsert;
        }
        //Traverse till end and add the bottom node 
        else {
            while (curr_node -> next != NULL) {
                curr_node = curr_node -> next;
            }
            curr_node -> next = nodeToInsert;
        }
    }
}

//Add2Inventory method to append nodes into linked list
void add2Inventory(struct maker * head, struct maker * prev, struct maker * nodeToInsert) {
    //Flag for added
    int added = -1;
    struct maker * currNode;
    if (head == NULL) {
        return;
    }
    //Traverse linked list and add to either bottom or top level
    currNode = head;
    while (currNode != NULL) {
        //Add to bottom node if the car maker is already in the top level
        if ((strcmp(nodeToInsert -> maker, currNode -> maker) == 0) & (added < 0)) {
            addToBottom(currNode, nodeToInsert);
            added = 1;
        }
        currNode = currNode -> next;
    }
    //If spot available in top level add to top
    if (added < 0) {
        addToList(head, prev, nodeToInsert);
    }
}

//Prints the contents of the structure
void printContents(struct maker * anObj) {
    printf("%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s"
        "\n",
        anObj -> maker,
        anObj -> model,
        anObj -> trim,
        anObj -> km,
        anObj -> year,
        anObj -> type,
        anObj -> driveTrain,
        anObj -> transmission,
        anObj -> stock,
        anObj -> status,
        anObj -> fuelEcon,
        anObj -> features);
};

//Search inventory method
void searchInventory(struct searchHash hashToSearch, struct maker * head) {
    //Map key to integer so it can be accessed in switch case
    if (head == NULL) {
        return;
    }
    int k = 0;
    struct maker * currNode = head;
    char ch_arr[12][15] = {
        "maker",
        "model",
        "trim",
        "km",
        "year",
        "type",
        "driveTrain",
        "transmission",
        "stock",
        "status",
        "fuelEcon",
        "features"
    };
    for (int i = 0; i < 11; i++) {
        if (strcmp(ch_arr[i], hashToSearch.key) == 0) {
            k = i;
            break;
        }
    }
    //Traverse 2D linked list
    switch (k) {
        case 0:
            while(currNode!=NULL){
                if(strcmp(hashToSearch.value, currNode -> maker) == 0){
                    printContents(currNode);
                }
                if(currNode -> bottom != NULL){
                    struct maker *temp = currNode -> bottom;
                    while (temp != NULL){
                        if (strcmp(hashToSearch.value, temp -> maker) == 0) {
                            printContents(temp);
                        }
                        temp = temp -> next;
                    }
                }
                currNode = currNode -> next;
            }
            break;
        case 4:
            while(currNode!=NULL){
                if(strcmp(hashToSearch.value, currNode -> year) == 0){
                    printContents(currNode);
                }
                if(currNode -> bottom != NULL){
                    struct maker *temp = currNode -> bottom;
                    while (temp != NULL){
                        if (strcmp(hashToSearch.value, temp -> year) == 0) {
                            printContents(temp);
                        }
                        temp = temp -> next;
                    }
                }
                
                currNode = currNode -> next;
            }

            break;

        default:
            break;
    }
    //NOTE - ONLY "maker" & "year" CAN BE SEARCHED SINCE CASE 0 AND CASE 4 USED
    //ONLY 2 CASES SHOWN AS EACH CASE IS VERY LONG
    //SIMPLY REPEAT SAME PROCESS FOR ALL CASES TO SEARCH ANY VALUE

}

//Save contents in linked list into a txt file
void saveCatalogue2File(struct maker * head) {
    struct maker * currNode = head;
    char sentence[1000];

    FILE * fptr;

    fptr = fopen("LinkedListContents.txt", "w");

    if (fptr == NULL) {
        printf("Error!");
        exit(1);
    }
    //Traverse linked list upper level
    while (currNode != NULL) {
        fprintf(fptr, "%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s""\n",
        currNode -> maker,
        currNode -> model,
        currNode -> trim,
        currNode -> km,
        currNode -> year,
        currNode -> type,
        currNode -> driveTrain,
        currNode -> transmission,
        currNode -> stock,
        currNode -> status,
        currNode -> fuelEcon,
        currNode -> features);
        if (currNode -> bottom != NULL) {
            //Traverse linked list bottom level
            struct maker * temp = currNode -> bottom;
            while (temp != NULL) {
                fprintf(fptr, "%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s""\n",
                currNode -> maker,
                currNode -> model,
                currNode -> trim,
                currNode -> km,
                currNode -> year,
                currNode -> type,
                currNode -> driveTrain,
                currNode -> transmission,
                currNode -> stock,
                currNode -> status,
                currNode -> fuelEcon,
                currNode -> features);
                temp = temp -> next;
            }
        }
        currNode = currNode -> next;
    }

    fclose(fptr);
}

//Counts number of lines in the txt file
int countLines() {
    FILE * fp;
    int count = 0;
    char c;

    fp = fopen("sortedListings.txt", "r");

    if (fp == NULL) {
        printf("Could not open file %s", "sortedListings.txt");
        return 0;
    }

    for (c = getc(fp); c != EOF; c = getc(fp))
        if (c == '\n')
            count = count + 1;

    fclose(fp);
    return (count);
}



int main(int argc, char const * argv[]) {
    //Initial values used throughout
    FILE * fp;
    char * line = NULL;
    size_t len = 0;
    ssize_t read;
    int numOfNodesAdded = 0;
    int k = 0;
    int x = countLines();
    //Arr stores dummy structs
    struct maker arr[x];

    //Open txt file
    fp = fopen("sortedListings.txt", "r");
    if (fp == NULL)
        exit(EXIT_FAILURE);

    //m1 is dummy struct to initialize values
    struct maker m1;
    //Node to add into the linked list
    struct maker * nodeToAdd;
    //Head and prev of linked list
    struct maker * head;
    struct maker * prev;
    head = malloc(sizeof(struct maker));
    prev = malloc(sizeof(struct maker));
    nodeToAdd = malloc(sizeof(struct maker));

    //While there is a line in the txt file
    while ((read = getline( & line, & len, fp)) != -1) {


        char features[100];

        //Extract features from the line
        char *temp = strchr(line, '{');
        char ending[1] = {'\0'};

        
        int j = 0;

        for (int i = 0; i < strlen(temp); i++)
        {
            features[i] = temp[i];
        }

        //Split line by , delimiter
        char * token = strtok(line, ",");
        //int mapping from token to struct variables
        while (token != NULL) {
            switch (j) {
                case 0:
                    strcpy(m1.maker, token);
                    break;
                case 1:
                    strcpy(m1.model, token);
                    break;
                case 2:
                    strcpy(m1.trim, token);
                    break;
                case 3:
                    strcpy(m1.km, token);
                    break;
                case 4:
                    strcpy(m1.year, token);
                    break;
                case 5:
                    strcpy(m1.type, token);
                    break;
                case 6:
                    strcpy(m1.driveTrain, token);
                    break;
                case 7:
                    strcpy(m1.transmission, token);
                    break;
                case 8:
                    strcpy(m1.stock, token);
                    break;
                case 9:
                    strcpy(m1.status, token);
                    break;
                case 10:
                    strcpy(m1.fuelEcon, token);
                    break;
                case 11:
                    strncpy(m1.features,features,100);
                default:
                    break;
            }
            token = strtok(NULL, ", ");
            j++;
            if(j > 11){
                break;
            }
        }

        //Creating a head node if number of nodes added is zero
        if (numOfNodesAdded == 0) {
            strcpy(head -> maker, m1.maker);
            strcpy(head -> model, m1.model);
            strcpy(head -> trim, m1.trim);
            strcpy(head -> km, m1.km);
            strcpy(head -> year, m1.year);
            strcpy(head -> type, m1.type);
            strcpy(head -> driveTrain, m1.driveTrain);
            strcpy(head -> transmission, m1.transmission);
            strcpy(head -> stock, m1.stock);
            strcpy(head -> status, m1.status);
            strcpy(head -> fuelEcon, m1.fuelEcon);
            strcpy(head -> features, m1.features);
            head -> bottom = NULL;
            head -> next = NULL;
            prev = head;
            numOfNodesAdded++;

        //Creating a node to add to the linked list
        } else {
            strcpy(arr[k].maker, m1.maker);
            strcpy(arr[k].model, m1.model);
            strcpy(arr[k].trim, m1.trim);
            strcpy(arr[k].km, m1.km);
            strcpy(arr[k].year, m1.year);
            strcpy(arr[k].type, m1.type);
            strcpy(arr[k].driveTrain, m1.driveTrain);
            strcpy(arr[k].transmission, m1.transmission);
            strcpy(arr[k].stock, m1.stock);
            strcpy(arr[k].status, m1.status);
            strcpy(arr[k].fuelEcon, m1.fuelEcon);
            strcpy(arr[k].features, m1.features);
            arr[k].bottom = NULL;
            arr[k].next = NULL;

            //Add to the linked list
            add2Inventory(head, prev, &arr[k]);
            prev = & arr[k];
            k++;
            numOfNodesAdded++;
            memset(features, 0, 100);

        }
    }
    //Testing the functions
    struct searchHash myHash;
    strcpy(myHash.key, "year");
    strcpy(myHash.value, "2017");
    searchInventory(myHash, head);
    saveCatalogue2File(head);

}