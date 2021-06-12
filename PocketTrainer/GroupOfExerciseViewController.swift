//
//  GroupOfExerciseViewController.swift
//  PocketTrainer
//
//  Created by Misha on 02.03.2021.
//  Copyright © 2021 Misha. All rights reserved.
//
import UIKit


class GroupOfExerciseViewController: UIViewController {
   
    var addExArray : [String] = []
    var completion: (([String]) -> ())?
    var text = ""
    var showOrAdd = "show"
    var nameAddTraining : String = ""
    var training: [Training] = [
        Training(group: "Пресс", exerciseName: "Передняя планка", image: "image_plank", majorMuscles: "плечи, грудные мышцы, пресс, квадрицепс", extraMuscles: "-" , complexityOfImplementation: "легкая", equipment: "не требуется", description: "Примите горизонтальное положение на полу, удерживая вес тела на предплечьях и пальцах ног. Находитесь в таком положении максимально долго. корпус тела при этом должен всегда оставаться прямым.", calories: 10.0),
        Training(group: "Пресс", exerciseName: "Подъем ног в висе", image: "image_leg_lift_attache", majorMuscles: "пресс", extraMuscles: "предплечья, квадрицепс", complexityOfImplementation: "средняя", equipment: "турник", description: "Прямым хватом возьмитесь за турник. Ноги вытянуты вдоль тела и немного согнуты в коленях. На выдохе поднимите ноги максимально вверх. На вдохе вернитесь в исходное положение.", calories: 10.0),
        Training(group: "Пресс", exerciseName: "Скручивания на скамье", image: "image_twists", majorMuscles: "пресс", extraMuscles: "-", complexityOfImplementation: "легкая", equipment: "не требуется", description: "Примите горизонтальное положение на спине, положив руки за голову. Ноги поднимите на скамью. На выдохе поднимите корпус вверх и коснитесь подбородком колена. На вдохе вернитесь в исходное положение.", calories: 10.0),
        Training(group: "Бицепс", exerciseName: "Сгибания рук со штангой", image: "image_flexing_arms_barbell", majorMuscles: "бицепс", extraMuscles: "предплечья", complexityOfImplementation: "легкая", equipment: "штанга", description: "Встаньте прямо и возьмите штангу обратным хватом на расстоянии ширины плеч. На выдохе, удерживая плечи неподвижными, поднимите штангу до уровня плеч. На вдохе вернитесь в исходную позицию.", calories: 10.0),
        Training(group: "Бицепс", exerciseName: "Сгибание рук в тренажере", image: "image_flexing_arm_crossover", majorMuscles: "бицепс", extraMuscles: "предплечья", complexityOfImplementation: "легкая", equipment: "кроссовер", description: "Возьмите рукоять нижнего блока обратным хватом. На выдохе, поднимите руки. Следите, чтобы верхняя часть рук оставалась неподвижной. На вдохе медленно опустите руки в исходное положение.", calories: 10.0),
        Training(group: "Бицепс", exerciseName: "Сгибания рук с гантелями", image: "image_flexing_arms_dumbbel", majorMuscles: "бицепс", extraMuscles: "предплечья", complexityOfImplementation: "легкая", equipment: "гантели", description: "Возьмите гантели и встаньте прямо. Удерживая плечи неподвижными, поднимите одну руку и подведите гантель к плечу, одновременно повернув запястье. Вернитесь в исходную позицию. Повторите выполнение упражнения другой рукой.", calories: 10.0),
        Training(group: "Трицепс", exerciseName: "Разгибания рук в тренажере", image: "image_arm_spreading_crossover", majorMuscles: "трицепс", extraMuscles: "-", complexityOfImplementation: "легкая", equipment: "кроссовер", description: "Возьмите рукоять троса, прикрепленного к тренажеру для верхней тяги, и немного наклонитесь вперед. Опустите блок вниз, пока не коснетесь бедер. Сделайте паузу и верните рукояти в исходное положение.", calories: 10.0),
        Training(group: "Трицепс", exerciseName: "Разгибания рук назад", image: "image_arm_extension_back", majorMuscles: "трицепс", extraMuscles: "-", complexityOfImplementation: "легкая", equipment: "гантели", description: "Наклоните туловище вперед, спину держите прямо, немного согните колени и наклонитесь вперед в талии, туловище и плечи должны быть практически параллельно полу. Между предплечьем и плечом угол в 90 градусов. Удерживая плечи в неподвижном состоянии, используйте трицепс для поднятия веса на выдохе, пока вся рука не будет полностью вытянута, на вдохе вернитесь в исходное положение.", calories: 10.0),
        Training(group: "Трицепс", exerciseName: "Французский жим лежа", image: "image_france_gym", majorMuscles: "трицепс", extraMuscles: "-", complexityOfImplementation: "средняя", equipment: "штанга", description: "Удерживая штангу прямым хватом, примите горизонтальное положение на скамье, выпрямите руки перед собой и медленно опустите штангу за голову. На вдохе согните руки, чтобы предплечье было перпендикулярно полу. На выдохе верните штангу в исходное положение. ", calories: 10.0),
        Training(group: "Грудные мышцы", exerciseName: "Жим штанги лежа", image: "image_gym_barbell", majorMuscles: "грудные мышцы", extraMuscles: "плечи, трицепс", complexityOfImplementation: "средняя", equipment: "штанга", description: "Примите горизонтальное положение на скамье, возьмите штангу широким хватом и поднимите над собой. На вдохе опустите штангу до уровня груди, на выдохе верните ее в исходную позицию. Гриф должен опускаться и подниматься по строго вертикальной траектории", calories: 10.0),
        Training(group: "Грудные мышцы", exerciseName: "Жим гантелей", image: "image_dumbbell_press", majorMuscles: "грудные мышцы", extraMuscles: "плечи, трицепс", complexityOfImplementation: "средняя", equipment: "гантели", description: "Примите горизонтальное положение на скамье и поместите гантели перед собой на уровне груди и на расстоянии ширины плеч. Ладони направлены вперед. На вдохе опустите гантели к бокам. на выдохе, поднимите ганители вверх.", calories: 10.0),
        Training(group: "Грудные мышцы", exerciseName: "Сведение рук в тренажере", image: "image_gym_crossover", majorMuscles: "грудные мышцы", extraMuscles: "-", complexityOfImplementation: "средняя", equipment: "кроссовер", description: "Встаньте между стойками и обеими руками возьмитесь за тросы, сведите их перед собой. Немного наклонитесь вперед, слегка согните локти. Одновременно разведите обе руки, ладони должны оказаться на уровне плеч. Затем вернитесь в исходную позицию.", calories: 10.0),
        Training(group: "Квадрицепс", exerciseName: "Приседания со штангой", image: "image_squats_barbell", majorMuscles: "квадрицепс, ягодицы", extraMuscles: "бицепс бедра, мышцы спины", complexityOfImplementation: "тяжелая", equipment: "штанга", description: "Возьмитесь за штангу широким хватом и положите гриф на плечи. Поясница должна находиться в прогибе, ноги на расстоянии ширины плеч, локти отведены назад, слегка сведены лопатки. На вдохе присядьте, не отрывая пяток от пола и наклонив корпус тела немного вперед. На выдохе встаньте в исходное положение.", calories: 10.0),
        Training(group: "Квадрицепс", exerciseName: "Жим ногами в тренажере", image: "image_leg_press", majorMuscles: "квадрицепс, ягодицы", extraMuscles: "бицепс бедра", complexityOfImplementation: "средняя", equipment: "тренажер", description: "Ноги лучше ставить ближе к верхнему краю платформы на расстоянии ширины плеч, носки развести немного в стороны. На вдохе опустите платформу, расслабив ноги. На выдохе поднимите платформу. При выполнении упражнения не разводите колени в стороны и не выпрямляйте полностью ноги.", calories: 10.0),
        Training(group: "Квадрицепс", exerciseName: "Разгибания ног в тренажере", image: "image_leg_extensions", majorMuscles: "квадрицепс", extraMuscles: "-", complexityOfImplementation: "легкая", equipment: "тренажер", description: "Задайте необходимый вес и сядьте в тренажер, валик должен распологаться низко, возле стопы. Руками возьмитесь за ручки, спина плотно прилегает к тренажеру. Движения ног делайте по полной амплитуде. Для распределения нагрузки на наружнюю поверхность бедра, необходимо поставить носки ближе друг к другу.", calories: 10.0)
    ]

    
    @IBOutlet weak var groupOfExerciseTable: UITableView!
    
    
    var array: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        groupOfExerciseTable.delegate = self
        groupOfExerciseTable.dataSource = self
        UserDefaults.standard.set(try? PropertyListEncoder().encode(training), forKey:"training")
        
        for train in training{
            if !array.contains(train.group){
                array.append(train.group)
            }
        }
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ExerciseViewController{
            dest.name = text
            dest.canEdit = false
            dest.isTraining = false
            
            if showOrAdd == "add"
            {
                dest.nameAddTraining = nameAddTraining
                dest.showOrAdd = "add"
            }
            dest.viewWillAppear(true)
            for train in training{
                if train.group == text{
                    dest.arrayExercise.append(train.exerciseName)
                }
            }
            completion?(addExArray)
            
        }
    }
    
}
extension GroupOfExerciseViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        text = array[indexPath.row]
        
        performSegue(withIdentifier: "goToExercise", sender: nil)
   }

}
extension GroupOfExerciseViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupOfExerciseCell", for: indexPath)
        
        cell.textLabel?.text = array[indexPath.row]
        cell.textLabel?.textAlignment = NSTextAlignment.center
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        
        groupOfExerciseTable.separatorStyle = .none
        return cell
    }
}
