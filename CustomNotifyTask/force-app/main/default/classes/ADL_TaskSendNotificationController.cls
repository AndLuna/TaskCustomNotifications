/*
 *  Criado por e Data: 01/11/2023 André Luna
 *  contato: 
 *  Objetivo: Servir de controller pra classe ADL_TaskSendNotification pegando informacoes do objeto pai da tarefa.
 *  Data da Ultima atualizacao e por quem: 01/11/2023  André Luna
 *
*/
public with sharing class ADL_TaskSendNotificationController {

    // Mapeia prefixos para tipos
    private static Map<String, String> prefixToType = new Map<String, String> {
        '006' => 'Opportunity',
        '001' => 'Account',
        '00Q' => 'Lead',
        '003' => 'Contact'
    };

    public class ObjectInfo {
        public String parentName { get; set; }
        public String objectType { get; set; }
    }

    public static ObjectInfo getTaskParentInfo(Task tarefa) {
        ObjectInfo info = new ObjectInfo();
        info.parentName = '';
        info.objectType = '';

        if (tarefa.WhatId != null) {
            String whatIdPrefix = String.valueOf(tarefa.WhatId).substring(0, 3);

            if (prefixToType.containsKey(whatIdPrefix)) {

                info.parentName = getObjectName(tarefa.WhatId, prefixToType.get(whatIdPrefix));
                info.objectType = prefixToType.get(whatIdPrefix);
            }
        } else if (tarefa.WhoId != null) {
            String whoIdPrefix = String.valueOf(tarefa.WhoId).substring(0, 3);

            if (prefixToType.containsKey(whoIdPrefix)) {
                info.parentName = getObjectName(tarefa.WhoId, prefixToType.get(whoIdPrefix));
                info.objectType = prefixToType.get(whoIdPrefix);
            }
        }

        return info;
    }

    private static String getObjectName(Id recordId, String sObjectType) {
        String query = 'SELECT Name FROM ' + sObjectType + ' WHERE Id = :recordId LIMIT 1';
        SObject[] records = Database.query(query);
        if (!records.isEmpty()) {
            return (String)records[0].get('Name');
        }
        return '';
    }
}
