/*
 *  Criado por e Data: 01/11/2023 André Luna
 *  contato: 
 *  Objetivo: Envia uma notificação personalizada com base na tarefa fornecida.
 *  Data da Ultima atualizacao e por quem: 01/11/2023  André Luna
 *
*/
public class ADL_TaskSendNotification {

    public static void enviarNotificacao(Task tarefa) {
        // Abrimos uma instância de Custom Notification
        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        
        String mensagem;
        ADL_TaskSendNotificationController.ObjectInfo info = ADL_TaskSendNotificationController.getTaskParentInfo(tarefa); //pego info do objeto pelo controller

        if (info.objectType != null && info.parentName != null && info.parentName != '') {
            mensagem = 'A tarefa \'' + tarefa.Subject + '\' foi criada referente a ' + info.objectType + ' \'' + info.parentName + '\'';
        } else {
            mensagem = 'A tarefa \'' + tarefa.Subject + '\' foi criada';
        }

        notification.setBody(mensagem);
        notification.setTitle('Tarefa Criada');
        notification.setSenderId(UserInfo.getUserId());
        
        //pego a custom notification criada
        CustomNotificationType type = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'Tarefas_Agendadas' LIMIT 1];
        if (type != null) {
            notification.setNotificationTypeId(type.Id);
        } else {
            System.debug('Custom Notification Type "Tarefas_Agendadas" não encontrado.');
            return;
        }

        notification.setTargetId(tarefa.OwnerId);
        notification.send(new Set<String>{UserInfo.getUserId()});
    }
}
